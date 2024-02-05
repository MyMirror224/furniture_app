import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/pages/user_information/user_information.dart';
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

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // calculate widget to show
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      // home: Consumer(
      //   builder: (context, ref, child) {
      //     // install the loading screen
      //     // ref.listen<bool>(
      //     //   isLoadingProvider,
      //     //   (_, isLoading) {
      //     //     if (isLoading) {
      //     //       LoadingScreen.instance().show(
      //     //         context: context,
      //     //       );
      //     //     } else {
      //     //       LoadingScreen.instance().hide();
      //     //     }
      //     //   },
      //     // );
      //     final isLoggedIn = ref.watch(isLoggedInProvider);
      //     final isVerify = ref.watch(isVerifyEmail);
      //     if (isLoggedIn) {
      //       return const MainView();
      //     } else {
      //       return const Login();
      //     }
      //   },
      // ),
      home: UserInformation(),
    );
  }
}
