


import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/typedef/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider<UserId?>((ref){
  final authState = ref.watch(authStateProvider).userId;
  return authState;
});