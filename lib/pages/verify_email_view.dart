import 'package:flutter/material.dart';
import 'package:furniture_app/pages/home_page.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/services/constain.dart';

import 'package:furniture_app/state/auth/auth_state_provider.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyEmailView extends ConsumerWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xff193d3d).withOpacity(0.9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                emailSent,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
               Text(
                emailSent2,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
               Text(
                resendEmail,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ref.read(authStateProvider.notifier).sendEmailVerification();
                  },
                  child:  Text(resendEmail2,
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  Login()),
                        (route) => false);
                  },
                  child:  Text(verified,
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
