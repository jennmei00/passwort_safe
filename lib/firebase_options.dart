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
    apiKey: 'AIzaSyAgg7tYTwDuwVMe1LSf-2Cqxnt-mAvCyM8',
    appId: '1:463431064647:web:2064af358b96a9b8bce562',
    messagingSenderId: '463431064647',
    projectId: 'passwordsafe-532ca',
    authDomain: 'passwordsafe-532ca.firebaseapp.com',
    storageBucket: 'passwordsafe-532ca.appspot.com',
    measurementId: 'G-2W0ZCSN133',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7mqPVxmhx6cME5gj8T5hUmYjPGG9VOTI',
    appId: '1:463431064647:android:f9f663476abfdd64bce562',
    messagingSenderId: '463431064647',
    projectId: 'passwordsafe-532ca',
    storageBucket: 'passwordsafe-532ca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPFu_TfUgIwbuMiNr2fALGnB1mvUUiqKs',
    appId: '1:463431064647:ios:eb857d0d71d24799bce562',
    messagingSenderId: '463431064647',
    projectId: 'passwordsafe-532ca',
    storageBucket: 'passwordsafe-532ca.appspot.com',
    iosClientId: '463431064647-aqf83mahhh666stg5j46r7a4mv7evk2i.apps.googleusercontent.com',
    iosBundleId: 'com.example.passwordSafe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPFu_TfUgIwbuMiNr2fALGnB1mvUUiqKs',
    appId: '1:463431064647:ios:eb857d0d71d24799bce562',
    messagingSenderId: '463431064647',
    projectId: 'passwordsafe-532ca',
    storageBucket: 'passwordsafe-532ca.appspot.com',
    iosClientId: '463431064647-aqf83mahhh666stg5j46r7a4mv7evk2i.apps.googleusercontent.com',
    iosBundleId: 'com.example.passwordSafe',
  );
}
