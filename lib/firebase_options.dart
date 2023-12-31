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
    apiKey: 'AIzaSyC8PSUMwpnBfAGVk7I15nGAWRoCOxACIgk',
    appId: '1:292507730375:web:dc5a0998725467732f99e2',
    messagingSenderId: '292507730375',
    projectId: 'flutter-21b37',
    authDomain: 'flutter-21b37.firebaseapp.com',
    storageBucket: 'flutter-21b37.appspot.com',
    measurementId: 'G-EH83PJZ0ND',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUaHJKZCGHmudqFKCzhvmZn3VhN90glK4',
    appId: '1:292507730375:android:3007cccea0a4a6ba2f99e2',
    messagingSenderId: '292507730375',
    projectId: 'flutter-21b37',
    storageBucket: 'flutter-21b37.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNAuJq9arg58E6EXifWegHDCDXnB2GawI',
    appId: '1:292507730375:ios:2bb92c7bbd62c6f22f99e2',
    messagingSenderId: '292507730375',
    projectId: 'flutter-21b37',
    storageBucket: 'flutter-21b37.appspot.com',
    iosClientId: '292507730375-1j5lire4i16v7mn318ubprianeij67fk.apps.googleusercontent.com',
    iosBundleId: 'com.example.nBaz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNAuJq9arg58E6EXifWegHDCDXnB2GawI',
    appId: '1:292507730375:ios:2bb92c7bbd62c6f22f99e2',
    messagingSenderId: '292507730375',
    projectId: 'flutter-21b37',
    storageBucket: 'flutter-21b37.appspot.com',
    iosClientId: '292507730375-1j5lire4i16v7mn318ubprianeij67fk.apps.googleusercontent.com',
    iosBundleId: 'com.example.nBaz',
  );
}
