import 'package:flutter/material.dart';
import 'package:flutter/painting.dart'; // Import the dart:ui package for Radius.circular.
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/components/login_signup/field_login.dart';
import 'package:furniture_app/pages/forgot_password/forgot_password.dart';
import 'package:furniture_app/pages/signup_page.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size; // ------ lấy nhanh size màn hình
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  //ClipRRect làm tròn 4 góc
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),

                  child: Image.asset(
                    'assets/images/background.jpg',
                    height: size.height * 0.3,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(5),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.black, // cần đổ màu
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(5),
                myTextField(Icons.person, 'Email',
                    emailController), // icon cũng cần đổ màu
                const Gap(15),
                myTextField(Icons.lock, 'Password', passwordController),
                const Gap(5),
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    ),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const Gap(15),
                buttonLogin("Login", Colors.grey, onpressed: () {
                  ref
                      .read(authStateProvider.notifier)
                      .loginWithEmailandPassword(emailController.toString(),
                          passwordController.toString());
                }),
                const Gap(15),
                const Center(
                  child: Text(
                    "_________OR _________",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => ref
                          .read(authStateProvider.notifier)
                          .loginWithFacebook(),
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () => ref
                          .read(authStateProvider.notifier)
                          .loginWithGoogle(),
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.red),
                    ), // Use the correct named parameter 'data' and provide a positional argument.
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  SignUp(),
                        )
                      ),
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                        )
                      )
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
