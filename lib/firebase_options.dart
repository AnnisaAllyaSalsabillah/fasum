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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC-NXmX4ysdRBUkKKIV7RfcPPgpaHwJb2E',
    appId: '1:195333178462:web:e12f0444f3d8f301aa60cf',
    messagingSenderId: '195333178462',
    projectId: 'fasum-da36b',
    authDomain: 'fasum-da36b.firebaseapp.com',
    storageBucket: 'fasum-da36b.firebasestorage.app',
    measurementId: 'G-J6HYKEB7WH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDj7zaphZsEAzXqG0NheONt9gMRjaysLH0',
    appId: '1:195333178462:android:d508f8af2ab78c71aa60cf',
    messagingSenderId: '195333178462',
    projectId: 'fasum-da36b',
    storageBucket: 'fasum-da36b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjfeLsXtKPuUZ9MNrF9X6QafZIpYwU9Fc',
    appId: '1:195333178462:ios:dc1d23d993865bf1aa60cf',
    messagingSenderId: '195333178462',
    projectId: 'fasum-da36b',
    storageBucket: 'fasum-da36b.firebasestorage.app',
    iosBundleId: 'com.example.fasum',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjfeLsXtKPuUZ9MNrF9X6QafZIpYwU9Fc',
    appId: '1:195333178462:ios:dc1d23d993865bf1aa60cf',
    messagingSenderId: '195333178462',
    projectId: 'fasum-da36b',
    storageBucket: 'fasum-da36b.firebasestorage.app',
    iosBundleId: 'com.example.fasum',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-NXmX4ysdRBUkKKIV7RfcPPgpaHwJb2E',
    appId: '1:195333178462:web:f021ef3657f4894faa60cf',
    messagingSenderId: '195333178462',
    projectId: 'fasum-da36b',
    authDomain: 'fasum-da36b.firebaseapp.com',
    storageBucket: 'fasum-da36b.firebasestorage.app',
    measurementId: 'G-XVWZ1Z3MPV',
  );

}