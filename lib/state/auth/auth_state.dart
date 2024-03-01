import 'package:furniture_app/state/auth/auth_result.dart';
import 'package:furniture_app/typedef/user_id.dart';

class AuthState {
  final AuthResult? authResult;
  final bool isLoading;
  final UserId? userId;
  final String errorMessage;
  const AuthState({
    required this.isLoading,
    required this.authResult,
    required this.userId,
    required this.errorMessage,
  });

  const AuthState.unknown()
      : isLoading = false,
        authResult = null,
        userId = null,
        errorMessage = '';

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        authResult: authResult,
        isLoading: isLoading,
        userId: userId,
        errorMessage: errorMessage,
      );
AuthState copiedWithIsResult(AuthResult result) => AuthState(
        authResult: result,
        isLoading: isLoading,
        userId: userId,
        errorMessage: '',
      );
      AuthState copiedWithIsMessage(String  errorMessage) => AuthState(
        authResult: authResult,
        isLoading: isLoading,
        userId: userId,
        errorMessage: errorMessage,
      );
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      isLoading == other.isLoading &&
          authResult == other.authResult &&
          userId == other.userId &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
        isLoading,
        authResult,
        userId,
        errorMessage,
      );
}
