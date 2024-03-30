import 'package:flutter/material.dart';
import 'package:furniture_app/components/dialog/dialog_auth.dart';
import 'package:furniture_app/components/dialog/dialog_model.dart';
import 'package:furniture_app/components/loading/loading_screen.dart';
import 'package:furniture_app/global.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/pages/mainview.dart';
import 'package:furniture_app/pages/navigator_bar.dart';
import 'package:furniture_app/pages/verify_email_view.dart';
import 'package:furniture_app/provider/error_message_provider.dart';
import 'package:furniture_app/provider/is_failure.dart';
import 'package:furniture_app/provider/is_loading_provider.dart';
import 'package:furniture_app/provider/is_logged_in_provider.dart';
import 'package:furniture_app/provider/is_not_verify_provider.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/themes/app_theme.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Global.init();

  runApp(const ProviderScope(
    child: App(),
  ));
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

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    var errorText = ref.watch(errorMessageProvider);
    return MaterialApp(
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );

          ref.listen<String>(errorMessageProvider, (_, errorMessage) {
            if (errorMessage != errorText) {
              errorText = errorMessage;
            }
          });

          var isFailure = ref.watch(isFailureProvider);
          final isNotVerify = ref.watch(isNotVerifyEmailProvider);
          final isLoggedIn = ref.watch(isLoggedInProvider);

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (isFailure) {
              final dialogBool = await AuthDialog(errorMessage: errorText)
                  .present(context)
                  .then((shouldDelete) => shouldDelete ?? true);
              if (dialogBool) {
                ref.read(authStateProvider.notifier).resetResult();
              }
            }
          });

          return MainView();

          if (isLoggedIn) {
            return HomeScreen();
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
