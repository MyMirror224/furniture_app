import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/pages/forgot_password/forgot_password.dart';
import 'package:furniture_app/pages/signup_page.dart';
import 'package:furniture_app/services/constain.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class Login extends ConsumerWidget {
  Login({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(obscurePasswordProvider);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return KeyboardDismisser(
      child: Scaffold(
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
                      ],
                    ),
                    const Gap(20),
                    Text(
                      signIn,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return enterEmail;
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return invalidEmail;
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        decoration:  InputDecoration(
                          labelText: email,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return enterPassword;
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        obscureText: loginNotifier.isObscure,
                        decoration: InputDecoration(
                          labelText: password,
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
                        child:  Text(
                          forgotPassword,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    const Gap(15),
                    buttonLogin(
                        login, Colors.grey, (deviceWidth * 0.3).toInt(), 50,
                        onpressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(authStateProvider.notifier)
                            .loginWithEmailandPassword(
                                emailController.text, passwordController.text);
                        final userId = ref.watch(authStateProvider).userId;
                        return ref
                            .refresh(userInfoModelProvider(userId.toString()));
                      }
                    }),
                    const Gap(15),
                     Center(
                      child: Text(
                        or,
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
                          dontHaveAccount,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        GestureDetector(
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      )),
                                },
                            child: const Text(" Sign Up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Create a provider to manage the state of your form
final obscurePasswordProvider =
    ChangeNotifierProvider((ref) => ObscurePasswordNotier());

class ObscurePasswordNotier extends ChangeNotifier {
  bool isObscure = true;

  void togglePasswordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
