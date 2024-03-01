import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final errorMessageProvider= Provider<String>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.errorMessage;
});