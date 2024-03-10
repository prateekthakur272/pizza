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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBF6OZPLlykeyltcxqHfSHG5YAZZ3Mm8CA',
    appId: '1:643615332694:web:849af29087d81360149ef7',
    messagingSenderId: '643615332694',
    projectId: 'pizza-budget-tracker',
    authDomain: 'pizza-budget-tracker.firebaseapp.com',
    storageBucket: 'pizza-budget-tracker.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNpxtdgoe5sBpFaIsKANntFB1FGUOP29o',
    appId: '1:643615332694:android:18b4cd73f893c3be149ef7',
    messagingSenderId: '643615332694',
    projectId: 'pizza-budget-tracker',
    storageBucket: 'pizza-budget-tracker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBcAjTP3Tc9BQ4O8gdI_2n_wGUWAErghg',
    appId: '1:643615332694:ios:78cb8f7b94ba2613149ef7',
    messagingSenderId: '643615332694',
    projectId: 'pizza-budget-tracker',
    storageBucket: 'pizza-budget-tracker.appspot.com',
    iosBundleId: 'prateekthakur.dev.pizza',
  );
}