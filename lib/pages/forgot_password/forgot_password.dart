import 'package:flutter/material.dart';
import 'package:furniture_app/components/forgot_password/fogot_button.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/wave_clipper_custom_appbar.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  get child => null;
  String? validateEmail(String email, BuildContext context) {
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(email)) {
      return _getEmailErrorMessage(email, context);
    }
    return null;
  }

  String? _getEmailErrorMessage(String email, BuildContext context) {
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!emailRegex.hasMatch(email)) {
      // Check for common email validation errors using regular expressions
      if (!email.contains('@')) {
        return context.loc.emailErrorMessage;
      } else if (!email.contains('.')) {
        return context.loc.emailErrorMessage2;
      } else if (email.startsWith('.') || email.endsWith('.')) {
        return context.loc.emailErrorMessage3;
      } else if (email.contains(' ')) {
        return context.loc.emailErrorMessage4;
      }
      // Add more checks for specific use cases as needed
      return context.loc.emailErrorMessage5;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    Size size = MediaQuery.of(context).size; // ------ lấy nhanh size màn hình
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff193d3d),
        toolbarHeight: 100,
        title: Text(
          context.loc.forgotPassword,
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
                        color: Color(0xff193d3d),
                        height: 100,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Color(0xff193d3d),
                      height: 80,
                    ),
                  ),
                  // const Text("Forgot Password",
                  //     style: TextStyle(
                  //       color: Colors.black, // chinh mau
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.bold,
                  //     )),
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
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: context.loc.ohno,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: context.loc.forgotPassword2,
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
                            text: TextSpan(children: [
                          TextSpan(
                              text: context.loc.dontworry,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text: context.loc.pleaseInput,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                      ),
                      const Gap(25),
                      // nhâp email và gửi

                      SizedBox(
                        width: 350.0,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.pleaseEnterYourEmail;
                            } else {
                              return validateEmail(value, context);
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: "Email Address",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Colors
                                      .red), // Màu sắc của đường biên khi có lỗi
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            suffixIcon:
                                Padding(padding: EdgeInsets.only(left: 30.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ForgotButton(
                        text: "Recover Password",
                        onTap: () async {
                          if (validateEmail(_emailController.text, context) ==
                              null) {
                            await ref
                                .read(authStateProvider.notifier)
                                .forgotPassword(_emailController.text);
                          }
                        },
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
