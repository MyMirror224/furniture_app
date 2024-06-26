import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/components/personal_button.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/pages/Invoice_history_page.dart';
import 'package:furniture_app/pages/change_language.dart';
import 'package:furniture_app/pages/notification_page.dart';
import 'package:furniture_app/pages/user_information/detail_information.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalPage extends ConsumerStatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonalPageState();
}

class _PersonalPageState extends ConsumerState<PersonalPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    String userName = user.hasValue ? user.value!.name.toString() : "User";
    String avatar = user.hasValue
        ? user.value!.avatar.toString()
        : 'storage/avatars/default.png';
    String avatarPath = '${AppConstants.SERVER_API_URL}$avatar';
    final appThemeState = ref.watch(themeNotifierProvider);
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
                    builder: (context) =>
                        DeteilInformationPage(userId.toString()),
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
                height: size.height * 0.07,
                width: size.width * 0.8,
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black45,
                    ),
                    const Gap(20),
                    Text(
                      context.loc.psnal,
                      style: const TextStyle(
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
            Container(
              height: size.height * 0.07,
              width: size.width * 0.9,
              child: PersonalButton(
                text: context.loc.myOrders,
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
            ),
            const Gap(10),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.9,
              child: PersonalButton(
                text: context.loc.language,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguagePage(),
                      ));
                },
                icon: FontAwesomeIcons.language,
              ),
            ),
            const Gap(10),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.9,
              child: PersonalButton(
                text: context.loc.notification,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NotificationPage(userId.toString()),
                      ));
                },
                icon: FontAwesomeIcons.bell,
              ),
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
                color: appThemeState == ThemeMode.dark
                    ? const Color(0xff93b1a7)
                    : const Color(0xff93b1a7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Gap(20),
                  Icon(Icons.contrast, color: Colors.black45),
                  Gap(20),
                  Expanded(
                    child: Text(context.loc.theme,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                  ),
                  DarkModeSwitch(),
                ],
              ),
            ),
            const Gap(10),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.9,
              child: PersonalButton(
                text: context.loc.logout,
                onTap: () {
                  ref.read(authStateProvider.notifier).logOut();
                },
                icon: FontAwesomeIcons.signOutAlt,
              ),
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
    final themeMode = ref.watch(themeNotifierProvider);
    return Switch(
      value: themeMode == ThemeMode.dark,
      activeColor: Color.fromARGB(255, 2, 31, 21),
      onChanged: (enabled) {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
    );
  }
}
