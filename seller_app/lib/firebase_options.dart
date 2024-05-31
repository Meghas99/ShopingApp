// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB83guqRyYDVh2vCUj-8e2q3RFI2YA5bfc',
    appId: '1:117502055684:web:52b98db8106737b6542c51',
    messagingSenderId: '117502055684',
    projectId: 'smart-b9daa',
    authDomain: 'smart-b9daa.firebaseapp.com',
    storageBucket: 'smart-b9daa.appspot.com',
    measurementId: 'G-LE9BBL546W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCph3nUp0MAjcAI_jL2XwVyQ9b3tdO2U8o',
    appId: '1:117502055684:android:9c38821f273fb2a5542c51',
    messagingSenderId: '117502055684',
    projectId: 'smart-b9daa',
    storageBucket: 'smart-b9daa.appspot.com',
  );
}
