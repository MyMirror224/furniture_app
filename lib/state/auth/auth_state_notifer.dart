import 'package:furniture_app/global.dart';
import 'package:furniture_app/model/user_info_model.dart';
import 'package:furniture_app/state/auth/auth_result.dart';
import 'package:furniture_app/state/auth/auth_state.dart';
import 'package:furniture_app/state/auth/authenticator.dart';
import 'package:furniture_app/state/user_info/backend/user_info_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = Authenticator();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn && _authenticator.isVerify) {
      state = AuthState(
        isLoading: false,
        authResult: AuthResult.sussess,
        userId: _authenticator.userId,
        errorMessage: '',
      );
    }
  }
  Future<void> toLogin() async {
    state = state.copiedWithIsLoading(true);
    state = const AuthState.unknown();
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.signOut();
    state = const AuthState.unknown();
  }

  Future<void> forgotPassword(String email) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.sendPasswordReset(
      toEmail: email,
    );
    if (result == AuthResult.failure) {
      state = AuthState(
        isLoading: false,
        authResult: result,
        userId: _authenticator.userId,
        errorMessage: 'Have error when send email',
      );
    }
    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: '',
    );
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    try {
      await _authenticator.createUserInDatabase(
          password: null, name: _authenticator.displayName.toString());

      final response =
          await UserAPI.getProfile(_authenticator.userId.toString());
      await Global.storageService.setProfile(
          _authenticator.userId.toString(), response.data as UserInfoModel);
    } catch (e) {
      state = AuthState(
        isLoading: false,
        authResult: AuthResult.failure,
        userId: userId,
        errorMessage: 'Server error',
      );
    }
    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: userId,
      errorMessage: '',
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    await _authenticator.createUserInDatabase(
        password: null, name: _authenticator.displayName.toString());

    final response = await UserAPI.getProfile(_authenticator.userId.toString());
    await Global.storageService.setProfile(
        _authenticator.userId.toString(), response.data as UserInfoModel);

    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: '',
    );
  }

  Future<void> sendEmailVerification() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.sendEmailVerification();

    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: '',
    );
  }

  Future<void> updatePassword(String newPassword) async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.updatePassword(
      newPassword: newPassword,
    );
    state = state.copiedWithIsLoading(false);
  }

  Future<void> loginWithEmailandPassword(String email, String password) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.logInWithEmailPassword(
        email: email, password: password);
    if (result == AuthResult.notVerified) {
      state = AuthState(
        isLoading: false,
        authResult: result,
        userId: _authenticator.userId,
        errorMessage: '',
      );
      return sendEmailVerification();
    }

    if (result == AuthResult.sussess) {
      await _authenticator.createUserInDatabase(
          password: password, name: _authenticator.displayName.toString());

      final response =
          await UserAPI.getProfile(_authenticator.userId.toString());
      await Global.storageService.setProfile(
          _authenticator.userId.toString(), response.data as UserInfoModel);
      

      state = AuthState(
        isLoading: false,
        authResult: result,
        userId: _authenticator.userId,
        errorMessage: '',
      );
    }

    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: _authenticator.errorMessage,
    );
  }
  

  Future<void> registerWithEmailandPassword(
      String email, String password, String name) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.registerWithEmailPassword(
      email: email,
      password: password,
      name: name,
    );
    if (result == AuthResult.resgistered) {
      return sendEmailVerification();
    }
    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: _authenticator.errorMessage,
    );
  }

  Future<void> resetPassword(String email) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.sendPasswordReset(toEmail: email);
    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: '',
    );
  }

  Future<void> resetResult() async {
    state = state.copiedWithIsResult(
      AuthResult.aborted,
    );
  }
}
