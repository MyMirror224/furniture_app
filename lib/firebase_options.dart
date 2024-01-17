// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQjeciyEcQyG1q8SKhqGsfIyMyFyStvcM',
    appId: '1:11058742887:web:473df9e12459772cf236c2',
    messagingSenderId: '11058742887',
    projectId: 'furniture-app-endgame',
    authDomain: 'furniture-app-endgame.firebaseapp.com',
    storageBucket: 'furniture-app-endgame.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPEI-Fpv1k1zNL0yqU_w26b6Tk9-Y6ED8',
    appId: '1:11058742887:android:0b71fbe8bf9b3829f236c2',
    messagingSenderId: '11058742887',
    projectId: 'furniture-app-endgame',
    storageBucket: 'furniture-app-endgame.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9p5hWu1ys6xAk82M6vuDiaaSe2gpWwDc',
    appId: '1:11058742887:ios:431166e3fe8599fbf236c2',
    messagingSenderId: '11058742887',
    projectId: 'furniture-app-endgame',
    storageBucket: 'furniture-app-endgame.appspot.com',
    iosBundleId: 'com.example.furnitureApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9p5hWu1ys6xAk82M6vuDiaaSe2gpWwDc',
    appId: '1:11058742887:ios:0d7d810d2bb4eaf1f236c2',
    messagingSenderId: '11058742887',
    projectId: 'furniture-app-endgame',
    storageBucket: 'furniture-app-endgame.appspot.com',
    iosBundleId: 'com.example.furnitureApp.RunnerTests',
  );
}
