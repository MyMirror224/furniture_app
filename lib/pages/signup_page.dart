import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/pages/verify_email_view.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/state/auth/is_registered.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class SignUp extends ConsumerWidget {
  SignUp({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final loginNotifier = ref.watch(loginProvider);
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
                SizedBox(
                  width: 350.0,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
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
                      suffixIcon: Padding(padding: EdgeInsets.only(left: 30.0)),
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
                      if (value!.isEmpty) {
                        return "please enter your password";
                      } else if (value.length < 6) {
                        return "password must be at least 6 characters";
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

                buttonLogin("Sign up", Colors.grey, (size.width * 0.5).toInt(),
                    (size.height * 0.07).toInt(), onpressed: () {
                  ref
                      .read(authStateProvider.notifier)
                      .registerWithEmailandPassword(
                          emailController.text, passwordController.text);
                  final registered = ref.watch(isRegistered);
                  if (registered) {
                    ref
                        .read(authStateProvider.notifier)
                        .sendEmailVerification();
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

// Create a provider to manage the state of your form

final passwordProvider = StateProvider<String?>((ref) => "");
