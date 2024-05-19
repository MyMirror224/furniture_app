import 'package:flutter/material.dart';
import 'package:furniture_app/components/forgot_password/fogot_button.dart';
import 'package:furniture_app/components/forgot_password/verify.dart';
import 'package:furniture_app/components/wave_clipper_custom_appbar.dart';
import 'package:furniture_app/pages/forgot_password/reset_password.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:gap/gap.dart';

class emailVerification extends StatelessWidget {
  const emailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // ------ lấy nhanh size màn hình
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          'Email Verification',
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
              //custom appBar
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
                      alignment: Alignment.center,
                      child: const Text(
                        'Get Verification Code',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Gap(size.height * 0.05),
                  //nội dung 2
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 25),
                    margin: const EdgeInsets.only(left: 15, right: 25),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: "Please enter ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                          text: "the 4 digit code ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: "that send to your email address.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ])),
                  ),
                  const Gap(25),
                  // nhâp code verification
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: VerifyCode(),
                  ),

                  // gui lai code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the code? ",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          " Resend Code!",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const Gap(15),
                  // button xác nhận
                  ForgotButton(
                      text: "Confirm",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Change Password'),
                              content: Text(
                                  'Please check your email to change password'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                        (route) => false); // Close the dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
