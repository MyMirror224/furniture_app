import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'auth_state_notifer.dart';
import 'auth_state.dart';
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);