import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/pages/verify_email_view.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignUp extends HookConsumerWidget {
  SignUp({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? validatePassword(String password, BuildContext _) {
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (!passwordRegex.hasMatch(password)) {
      return _getPasswordErrorMessage(password, _);
    }

    return null; // Mật khẩu hợp lệ
  }

  String? validateEmail(String email, BuildContext _) {
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(email)) {
      return _getEmailErrorMessage(email, _);
    }
    return null;
  }

  String? _getEmailErrorMessage(String email, BuildContext _) {
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!emailRegex.hasMatch(email)) {
      // Check for common email validation errors using regular expressions
      if (!email.contains('@')) {
        return _.loc.emailErrorMessage;
      } else if (!email.contains('.')) {
        return _.loc.emailErrorMessage2;
      } else if (email.startsWith('.') || email.endsWith('.')) {
        return _.loc.emailErrorMessage3;
      } else if (email.contains(' ')) {
        return _.loc.emailErrorMessage4;
      }
      // Add more checks for specific use cases as needed
      return _.loc.emailErrorMessage5;
    }
    return null;
  }

  String? _getPasswordErrorMessage(String password, BuildContext _) {
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasSpecialChar = password.contains(RegExp(r'[@$!%*?&]'));
    final hasMinLength = password.length >= 8;

    if (!hasLowercase) {
      return _.loc.passwordErrorMessage;
    }

    if (!hasUppercase) {
      return _.loc.passwordErrorMessage2;
    }

    if (!hasDigit) {
      return _.loc.passwordErrorMessage3;
    }

    if (!hasSpecialChar) {
      return _.loc.passwordErrorMessage4;
    }

    if (!hasMinLength) {
      return _.loc.passwordErrorMessage5;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    final loginNotifier = ref.watch(obscurePasswordProvider);

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(deviceWidth * 0.05),
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
                        context.loc.createNewAccount,
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
                              return context.loc.enterName;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: context.loc.name,
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
                              return context.loc.enterEmail;
                            } else {
                              return validateEmail(value, context);
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: context.loc.email,
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
                              return context.loc.enterPassword;
                            } else {
                              return validatePassword(value, context);
                            }
                          },
                          obscureText: loginNotifier.isObscure,
                          decoration: InputDecoration(
                            labelText: context.loc.password,
                            labelStyle: const TextStyle(color: Colors.black),
                            focusColor: Colors.blueAccent,
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                              return context.loc.enterPassword;
                            } else {
                              if (value != passwordController.text) {
                                return context.loc.passwordNotMatch;
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: context.loc.confirmPassword,
                            labelStyle: const TextStyle(color: Colors.black),
                            focusColor: Colors.blueAccent,
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                          context.loc.signUp,
                          Colors.grey,
                          (deviceHeight * 0.3).toInt(),
                          50, onpressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(authStateProvider.notifier)
                              .registerWithEmailandPassword(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyEmailView(),
                              ));
                        }
                      }),
                      const Gap(15),
                      Center(
                        child: Text(
                          context.loc.or,
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
                          Text(
                            context.loc.alreadyHaveAccount + ' ',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              context.loc.loginNow,
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
        ),
      ),
    );
  }
}
