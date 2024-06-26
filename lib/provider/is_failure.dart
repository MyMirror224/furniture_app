
import 'package:furniture_app/provider/isLockUser.dart';
import 'package:furniture_app/state/auth/auth_result.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isFailureProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return authState.authResult == AuthResult.failure  ;
});

final isLockProvider = Provider<bool>((ref) {
  final lockUser = ref.watch(lockUserProvider);
  return lockUser.isLockUser == true;
});