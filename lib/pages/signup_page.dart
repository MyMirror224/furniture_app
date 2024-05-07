import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/pages/verify_email_view.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUp extends HookConsumerWidget {
  SignUp({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController =TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? validatePassword(String password) {
  final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  if (!passwordRegex.hasMatch(password)) {
    return _getPasswordErrorMessage(password);
  }

  return null; // Mật khẩu hợp lệ
}

String? _getPasswordErrorMessage(String password) {
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  final hasUppercase = password.contains(RegExp(r'[A-Z]'));
  final hasDigit = password.contains(RegExp(r'\d'));
  final hasSpecialChar = password.contains(RegExp(r'[@$!%*?&]'));
  final hasMinLength = password.length >= 8;

  

  if (!hasLowercase) {
    return 'Must have at least one regular character (a-z)';
  }

  if (!hasUppercase) {
    return 'Must have at least one uppercase character (A-Z)';
  }

  if (!hasDigit) {
    return 'Must have at least one number (0-9)';
  }

  if (!hasSpecialChar) {
    return 'Must have at least one special character (@\$!%*?&)';
  }

  if (!hasMinLength) {
    return 'Must be at least 8 characters long';
  }
  return null;
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final loginNotifier = ref.watch(obscurePasswordProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        //ClipRRect làm tròn 4 góc
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)),

                        child: Image.asset(
                          'assets/images/background.png',
                          height: deviceHeight * 0.3,
                          width: deviceWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // const Gap(5),

                      // Positioned(
                      //   // đặt text tại vị trí ở nửa dưới của hình
                      //   bottom: 0,
                      //   left: size.width * 0.11,
                      //   child: Opacity(
                      //     opacity: 0.90,
                      //     child: Container(
                      //       padding: const EdgeInsets.only(left: 20, right: 20),
                      //       decoration: const BoxDecoration(
                      //         color: Color(0xff93b1a7),
                      //         borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(16),
                      //           topRight: Radius.circular(16),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         'Create new Account',
                      //         style: GoogleFonts.roboto(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 30,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    'Create new Account',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your name";
                        } 
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Màu sắc của đường biên khi có lỗi
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        suffixIcon:
                            Padding(padding: EdgeInsets.only(left: 30.0)),
                      ),
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    width: 350.0,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email";
                        } else if (!emailRegex.hasMatch(value)) {
                          return "please enter a valid email";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  ), // icon cũng cần đổ màu
                  const Gap(15),
                  SizedBox(
                    width: 350.0,
                    child: TextFormField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else {
                         validatePassword(value);
                        }
                        return null;
                      },
                      obscureText: loginNotifier.isObscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        focusColor: Colors.blueAccent,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Màu sắc của đường biên khi có lỗi
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginNotifier.isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          onPressed: () {
                            loginNotifier.togglePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                  ),
                  const Gap(15),
                  SizedBox(
                    width: 350.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: loginNotifier.isObscure,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else {
                          if (value != passwordController.text) {
                            return "passwords do not match";
                          }
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        focusColor: Colors.blueAccent,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Màu sắc của đường biên khi có lỗi
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginNotifier.isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          onPressed: () {
                            loginNotifier.togglePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                  ),

                  const Gap(15),

                  buttonLogin(
                      "Sign up", Colors.grey, (deviceHeight * 0.3).toInt(), 50,
                      onpressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authStateProvider.notifier)
                          .registerWithEmailandPassword(
                              emailController.text, passwordController.text , nameController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerifyEmailView(),
                          ));
                    }
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
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        
                        } ,
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
      ),
    );
  }
}
