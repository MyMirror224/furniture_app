import 'package:flutter/material.dart';
import 'package:furniture_app/components/forgot_password/fogot_button.dart';
import 'package:furniture_app/components/forgot_password/forgot_field.dart';
import 'package:furniture_app/components/wave_clipper_custom_appbar.dart';
import 'package:gap/gap.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      body: Column(
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

          // phần nội dung
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Gap(size.height * 0.1),
              //nội dung 2
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    margin: const EdgeInsets.only(left: 15, right: 25),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "Well done! Enter New Password\n\n",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text:
                            "Your new password must be different from previous used password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ])),
                  ),
                  const Gap(25),
                  // nhâp email và gửi
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //   left: 25,
                  //   right: 25,
                  // ),
                  // child: Container(
                  //   margin:
                  //       const EdgeInsets.only(top: 5, left: 10, right: 10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   padding: const EdgeInsets.all(5),
                  //   child: Row(
                  //     children: [
                  //       const Gap(20),
                  //       Icon(
                  //         Icons.email,
                  //         size: 30,
                  //         color: Colors.grey[600],
                  //       ),
                  //       Expanded(
                  //         child: TextFormField(
                  //           style: const TextStyle(color: Colors.black),
                  //           decoration: InputDecoration(
                  //               hintText: 'Email',
                  //               hintStyle: const TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //               filled: true,
                  //               fillColor: Colors.grey[200],
                  //               border: InputBorder.none,
                  //               labelStyle: const TextStyle(
                  //                   color: Colors.black, fontSize: 20)),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const PasswordField(
                      nameField: "New Password", icon: Icons.password),
                  const Gap(20),
                  const PasswordField(
                      nameField: "Confirm Password", icon: Icons.check),

                  // ),
                  const SizedBox(height: 20),
                  ForgotButton(text: "Recover Password", onTap: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
