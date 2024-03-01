import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:furniture_app/constant/firebase_field_collection.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/state/auth/auth_result.dart';

import 'package:furniture_app/state/auth/constants.dart';

import 'package:furniture_app/typedef/user_id.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  Authenticator();
  String get errorMessage => _errorMessage;
  String _errorMessage = '';

  void updateErorrMessage(String value) {
    _errorMessage = value;
  }

  bool get isAlreadyLoggedIn => userId != null;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;

  String get email => FirebaseAuth.instance.currentUser?.email ?? '';

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  Future<AuthResult> sendPasswordReset({
    required String toEmail,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: toEmail,
      );
      return AuthResult.reset;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> updatePassword({
    required String newPassword,
  }) {
    return FirebaseAuth.instance.currentUser?.updatePassword(newPassword)
        as Future<AuthResult>;
  }

  Future<AuthResult> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
    return AuthResult.sussess;
  }

  Future<AuthResult> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (currentUser?.emailVerified == false) {
        return AuthResult.notVerified;
      }
      if (await checkAdmin()) {
        return AuthResult.admin;
      }
      return AuthResult.sussess;
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == 'user-not-found') {
        updateErorrMessage('User Not Found');
      } else if (e.code == 'wrong-password') {
        updateErorrMessage('Wrong Password');
      } else if (e.code == 'invalid-email') {
        updateErorrMessage('Invalid Email');
      } else {
        updateErorrMessage('Login Failed.Please try again');
      }
      return AuthResult.failure;
    }
  }

  Future<bool> checkAdmin() async {
    bool check = false;
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      String value =
          userInfo.docs.first.get(FirebaseFieldName.userType).toString();

      value == 'admin' ? check = true : check = false;
    } catch (e) {
      return false;
    }

    return check;
  }

  Future<AuthResult> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.resgistered;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        updateErorrMessage('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        updateErorrMessage('Email Already In Use');
      } else if (e.code == 'invalid-email') {
        updateErorrMessage('Invalid Email');
      } else if (e.code == 'operation-not-allowed') {
        updateErorrMessage('Operation Not Allowed');
      } else {
        updateErorrMessage('Register Failed.Please try again');
      }
      
      return AuthResult.failure;
    }
  }

  Future<AuthResult> sendEmailVerification() async {
    await currentUser?.sendEmailVerification();
    if (currentUser!.emailVerified) {
      return AuthResult.verified;
    }
    return AuthResult.notVerified;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      return AuthResult.aborted;
    }
    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.sussess;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.sussess;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.sussess;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  
}
