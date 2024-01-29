import 'package:furniture_app/state/auth/auth_result.dart';
import 'package:furniture_app/typedef/user_id.dart';

class AuthState {
  final AuthResult? authResult;
  final bool isLoading;
  final UserId? userId;
  const AuthState({
    required this.isLoading,
    required this.authResult,
    required this.userId,
  });

  const AuthState.unknown(): 
    isLoading = false,
    authResult = null,
    userId = null;
   
 AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        authResult: authResult,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  bool operator == (covariant AuthState other) => identical(this, other) || 
    isLoading == other.isLoading &&
    authResult == other.authResult &&
    userId == other.userId; 

  @override
  int get hashCode => Object.hash(
    isLoading,
    authResult,
    userId,
  );
}