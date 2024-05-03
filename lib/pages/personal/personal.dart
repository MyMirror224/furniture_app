import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/personal_button.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/pages/Invoice_history_page.dart';
import 'package:furniture_app/pages/cart_page.dart';
import 'package:furniture_app/pages/user_information/user_information.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalPage extends ConsumerWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    String userName = user.hasValue ? user.value!.name.toString() : "User";
    String avatar = user.hasValue
        ? user.value!.avatar.toString()
        : 'storage/avatars/default.png';
    String avatarPath = '${AppConstants.SERVER_API_URL}$avatar';
    final appThemeState = ref.watch(appThemeStateNotifier);
    // ignore: unused_local_variable

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(20),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Changed to a circular shape
                image: DecorationImage(
                  image: NetworkImage(
                    avatarPath,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            const Gap(10),
            Center(
              child: Text(
                userName,
                style: const TextStyle(
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
              text: "My Orders",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoryInvoicePage(uid: userId.toString()),
                    ));
              },
              icon: FontAwesomeIcons.listCheck,
            ),
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
              width: size.width * 0.88,
              decoration: BoxDecoration(
                color: appThemeState.isDarkModeEnabled
                    ? const Color(0xff93b1a7)
                    : const Color(0xff93b1a7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Gap(20),
                  const Icon(Icons.contrast, color: Colors.black45),
                  const Gap(20),
                  const Text("Theme",
                      style: TextStyle(fontSize: 20, color: Colors.black87)),
                  Gap(size.width * 0.4),
                  const DarkModeSwitch(),
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
