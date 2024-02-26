import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:furniture_app/components/navigation_bar_main_view.dart';
import 'package:furniture_app/state/auth/is_admin_provider.dart';

import 'package:furniture_app/state/auth/user_id_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:furniture_app/themes/app_theme.dart';
import 'package:furniture_app/themes/theme_provider.dart';

import 'package:furniture_app/pages/home_page.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/pages/mainview.dart';
import 'package:furniture_app/pages/verify_email_view.dart';
import 'package:furniture_app/state/auth/is_logged_in_provider.dart';
import 'package:furniture_app/state/auth/is_not_verify_provider.dart';


import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: App(),
  ));
}

//check theme
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: const Text("Theme Switch"),
      ),
      body: const Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Light Mode"),
                DarkModeSwitch(),
                Text("Dark Mode"),
              ],
            ),
          ),
        ],
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

class App extends HookConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: Consumer(
        builder: (context, ref, child) {
          // install the loading screen
          // ref.listen<bool>(
          //   isLoadingProvider,
          //   (_, isLoading) {
          //     if (isLoading) {
          //       LoadingScreen.instance().show(
          //         context: context,
          //       );
          //     } else {
          //       LoadingScreen.instance().hide();
          //     }
          //   },
          // );
          
          final isNotVerify = ref.watch(isNotVerifyEmailProvider);
          final isLoggedIn = ref.watch(isLoggedInProvider);
          final isAdmin = ref.watch(isAdminProvider);
          if(isAdmin){
            return MainView();
          }
          if (isLoggedIn) {
              return   HomePage();
          } else if (isNotVerify) {
            return const VerifyEmailView();
          } else {
            return Login();
          }
        },
      ),
      //home: NavigationMainView(),
    );
  }
}
