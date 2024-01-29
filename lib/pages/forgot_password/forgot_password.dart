import 'package:flutter/material.dart';
import 'package:furniture_app/components/forgot_password/fogot_button.dart';
import 'package:furniture_app/components/forgot_password/forgot_field.dart';
import 'package:furniture_app/pages/forgot_password/email_verification.dart';
import 'package:gap/gap.dart';

import '../../components/wave_clipper_custom_appbar.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  get child => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // ------ lấy nhanh size màn hình
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black, // chinh mau
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //custom appbar
              Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Colors.deepOrangeAccent,
                        height: 100,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.deepOrangeAccent,
                      height: 80,
                    ),
                  ),
                ],
              ),
              const Gap(35),
              // phần nội dung
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.only(left: 20),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Ow no! ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' You forgot your password ?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(size.height * 0.075),
                  //nội dung 2
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 25),
                        margin: const EdgeInsets.only(left: 15, right: 25),
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "Don't Worry!\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text:
                                "Please enter your email address. You will receive a link to create a new password via email.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                      ),
                      const Gap(25),
                      // nhâp email và gửi

                      const PasswordField(
                          nameField: "Email", icon: Icons.email),
                      const SizedBox(height: 20),
                      ForgotButton(
                        text: "Recover Password",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const emailVerification(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
