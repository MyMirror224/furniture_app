import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:furniture_app/components/dialog/dialog_auth.dart';
import 'package:furniture_app/components/dialog/dialog_model.dart';
import 'package:furniture_app/components/loading/loading_screen.dart';
import 'package:furniture_app/global.dart';
import 'package:furniture_app/l10n/l10n.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/pages/navigator_bar.dart';
import 'package:furniture_app/pages/verify_email_view.dart';
import 'package:furniture_app/provider/error_message_provider.dart';
import 'package:furniture_app/provider/isLockUser.dart';
import 'package:furniture_app/provider/is_failure.dart';
import 'package:furniture_app/provider/is_loading_provider.dart';
import 'package:furniture_app/provider/is_logged_in_provider.dart';
import 'package:furniture_app/provider/is_not_verify_provider.dart';
import 'package:furniture_app/provider/region_provider.dart';
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
    final appThemeState = ref.watch(themeNotifierProvider);
    return Switch(
      value: appThemeState == ThemeMode.dark ? true : false,
      onChanged: (enabled) {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
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
    final appThemeState = ref.watch(themeNotifierProvider);
    final locale = ref.watch(localeProvider);

    var errorText = ref.watch(errorMessageProvider);
    return MaterialApp(
      supportedLocales: L10n.all,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode:
          appThemeState == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
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
          var isLockUser = ref.watch(isLockProvider);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (isFailure) {
              final dialogBool = await AuthDialog(errorMessage: errorText)
                  .present(context)
                  .then((shouldDelete) => shouldDelete ?? true);
              if (dialogBool) {
                ref.read(authStateProvider.notifier).resetResult();
              }
            }
            if (isLockUser) {
              final dialogBool2 =
                  await AuthDialog(errorMessage: "Account locked")
                      .present(context)
                      .then((shouldDelete) => shouldDelete ?? true);
              if (dialogBool2) {
                ref.read(authStateProvider.notifier).logOut();
                ref.read(lockUserProvider.notifier).setLock();
              }
            }
          });

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
