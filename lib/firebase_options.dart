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
    apiKey: 'AIzaSyBx1VUVU_xerCrjeFJKJpakzuUHLjWpRwI',
    appId: '1:741226273836:web:2c80fd9a831658c15ac589',
    messagingSenderId: '741226273836',
    projectId: 'intellensense',
    authDomain: 'intellensense.firebaseapp.com',
    storageBucket: 'intellensense.appspot.com',
    measurementId: 'G-C1JW45PR4B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvjeiGXyBNK1ks1Z8uAmXU9vizd7K5l7s',
    appId: '1:741226273836:android:aa19bdcea261b1f85ac589',
    messagingSenderId: '741226273836',
    projectId: 'intellensense',
    storageBucket: 'intellensense.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxhXm2uXBskN1eNWYdcwE5KKbLHcwQfzo',
    appId: '1:741226273836:ios:b00ab5884d8adcd45ac589',
    messagingSenderId: '741226273836',
    projectId: 'intellensense',
    storageBucket: 'intellensense.appspot.com',
    androidClientId: '741226273836-s8f548mq7t68sr8lcg29ql8ntnccv86p.apps.googleusercontent.com',
    iosClientId: '741226273836-b5r29simfarfbfqebkjl4ta96pqjhbeu.apps.googleusercontent.com',
    iosBundleId: 'com.political.pulse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxhXm2uXBskN1eNWYdcwE5KKbLHcwQfzo',
    appId: '1:741226273836:ios:b00ab5884d8adcd45ac589',
    messagingSenderId: '741226273836',
    projectId: 'intellensense',
    storageBucket: 'intellensense.appspot.com',
    androidClientId: '741226273836-s8f548mq7t68sr8lcg29ql8ntnccv86p.apps.googleusercontent.com',
    iosClientId: '741226273836-b5r29simfarfbfqebkjl4ta96pqjhbeu.apps.googleusercontent.com',
    iosBundleId: 'com.political.pulse',
  );
}
