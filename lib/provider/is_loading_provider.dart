import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final payment = ref.watch(cartProvider).isLoading;
  return authState.isLoading || payment == true;
});
