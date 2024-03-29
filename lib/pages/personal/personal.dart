import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/personal_button.dart';
import 'package:furniture_app/pages/user_information/user_information.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalPage extends ConsumerWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Gap(20),
                  Center(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/user.jpg',
                          fit: BoxFit.cover,
                        ),
                        // child: Container(
                        // color: Colors.grey,
                        // child: Icon(
                        //   Icons.person,
                        //   size: size.height * 0.1,
                        //   color: Colors.black,
                        // ),
                      ),
                    ),
                  ),

                  const Gap(10),
                  const Center(
                    child: Text(
                      "Nguyễn Văn A",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      //move to UserInformation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInformation(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5d8374),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.07,
                      child: const Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.user,
                            color: Colors.black45,
                          ),
                          Gap(20),
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 30.0,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: Colors.grey,
                  ),
                  PersonalButton(
                    text: "My Cards",
                    onTap: () {},
                    icon: FontAwesomeIcons.wallet,
                  ),
                  const Gap(10),
                  PersonalButton(
                    text: "Shoping Address",
                    onTap: () {},
                    icon: FontAwesomeIcons.addressCard,
                  ),
                  // const Gap(10),
                  // PersonalButton(
                  //   text: "Discount",
                  //   onTap: () {},
                  //   icon: Icons.discount,
                  // ),
                  const Gap(10),
                  PersonalButton(
                    text: "Language",
                    onTap: () {},
                    icon: FontAwesomeIcons.language,
                  ),
                  const Gap(10),
                  PersonalButton(
                    text: "Notification",
                    onTap: () {},
                    icon: FontAwesomeIcons.bell,
                  ),
                  // const Gap(10),
                  // PersonalButton(
                  //   text: "Reset Password",
                  //   onTap: () {},
                  //   icon: Icons.lock,
                  // ),
                  const Gap(10),
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: appThemeState.isDarkModeEnabled
                          ? const Color(0xff93b1a7)
                          : const Color(0xff93b1a7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Gap(20),
                        Icon(Icons.contrast, color: Colors.black45),
                        Gap(20),
                        Text("Theme",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87)),
                        Gap(180),
                        DarkModeSwitch(),
                      ],
                    ),
                  ),
                  const Gap(10),
                  PersonalButton(
                    text: "Logout",
                    onTap: () => ref.read(authStateProvider.notifier).logOut(),
                    icon: FontAwesomeIcons.signOutAlt,
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

class DarkModeSwitch extends HookConsumerWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Switch(
      value: appThemeState.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          appThemeState.setDarkTheme();
        } else {
          appThemeState.setLightTheme();
        }
      },
    );
  }
}
