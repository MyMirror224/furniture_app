
import 'package:flutter/material.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyEmailView extends ConsumerWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(authStateProvider.notifier).sendEmailVerification();
          },
          child: const Text("Verify email"),
        ),
      ),
    );
  }
}