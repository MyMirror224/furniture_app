import 'package:flutter/material.dart';
// Import the dart:ui package for Radius.circular.
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/pages/forgot_password/forgot_password.dart';
import 'package:furniture_app/pages/signup_page.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends ConsumerWidget {
  Login({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final loginNotifier = ref.watch(obscurePasswordProvider);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
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
                  ClipRRect(
                    //ClipRRect làm tròn 4 góc
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),

                    child: Image.asset(
                      'assets/images/background.jpg',
                      height: deviceHeight * 0.3,
                      width: deviceWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 350.0,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      controller: emailController,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
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
                  buttonLogin(
                      "Login", Colors.grey, (size.width * 0.3).toInt(), 50,
                      onpressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authStateProvider.notifier)
                          .loginWithEmailandPassword(
                              emailController.text, passwordController.text);
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
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      GestureDetector(
                          onTap: () => {
                                Navigator.pop(context),
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
