import 'package:flutter/material.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext _, WidgetRef ref) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () => ref.read(authStateProvider.notifier).logOut(),
      child: const Text("Sign out"),
    )));
  }
}
