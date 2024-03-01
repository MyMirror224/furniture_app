import 'package:furniture_app/state/auth/auth_result.dart';
import 'package:furniture_app/state/auth/auth_state.dart';
import 'package:furniture_app/state/auth/authenticator.dart';
import 'package:furniture_app/state/user_info/backend/user_info_storage.dart';
import 'package:furniture_app/typedef/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown())  ;  

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.signOut();
    state = const AuthState.unknown();
  }

  Future<void> logInAnonymously() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signInAnonymously();
    final userId = _authenticator.userId;
    if (result == AuthResult.sussess && userId != null) {
      state = AuthState(
        isLoading: false,
        authResult: result,
        userId: userId,
        errorMessage: '',
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.sussess && userId != null) {
      await createUserInfoWithGGandFB(userId: userId);
    }
    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: '',
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.sussess && userId != null) {
      await createUserInfoWithGGandFB(userId: userId);
    }
    state = AuthState(
      isLoading: false,
      authResult: result,
      userId: _authenticator.userId,
      errorMessage: '',
    );
  }

  Future<void> createUserInfoWithGGandFB({
    required UserId userId,
  }) =>
      _userInfoStorage.createUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
        password: '',
      );
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
    if (result == AuthResult.admin) {
      state = AuthState(
        isLoading: false,
        authResult: result,
        userId: _authenticator.userId,
        errorMessage: '',
      );
    }
    if (result == AuthResult.sussess) {
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
      String email, String password) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.registerWithEmailPassword(
      email: email,
      password: password,
    );
    if (result == AuthResult.resgistered) {
      _userInfoStorage.createUserInfo(
          userId: _authenticator.userId ?? '',
          displayName: _authenticator.displayName,
          email: email,
          password: password);
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
  Future<void> resetResult()  async {
    state = state.copiedWithIsResult(AuthResult.aborted, );
  }
 
}