import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';

import 'package:furniture_app/components/login_signup/field_login.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:gap/gap.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(5),
                const Text(
                  'create new account',
                  style: TextStyle(
                    color: Colors.black, // cần đổ màu
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                myTextField(Icons.person, 'name'),
                const Gap(10),
                myTextField(Icons.email, 'Email'), // icon cũng cần đổ màu
                const Gap(10),
                myTextField(Icons.lock, 'Password'),
                const Gap(10),
                myTextField(Icons.lock, 'Confirm Password'),

                const Gap(15),
                ButtonLogin("Sign up", Colors.grey),
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
                      onPressed: () => null,
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () => null,
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
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login())),
                      child: const Text(
                        " Login now",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
