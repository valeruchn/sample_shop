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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDxH-sygQS1hb3hbbnqt5G_ZEC-6Xa0pOQ',
    appId: '1:212673942750:web:6d0ae362146067d5dc9e4f',
    messagingSenderId: '212673942750',
    projectId: 'pizza-shop-182a5',
    authDomain: 'pizza-shop-182a5.firebaseapp.com',
    storageBucket: 'pizza-shop-182a5.appspot.com',
    measurementId: 'G-JVFVNNY51R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB21WouRNmW4L9hQM9T1Xq89lI8W6Ioe1s',
    appId: '1:212673942750:android:db7ad16f4b3e17a6dc9e4f',
    messagingSenderId: '212673942750',
    projectId: 'pizza-shop-182a5',
    storageBucket: 'pizza-shop-182a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwvuBScVTAvC1WN8yXJXgK0JroozzqHWY',
    appId: '1:212673942750:ios:92c6a22f7171c4addc9e4f',
    messagingSenderId: '212673942750',
    projectId: 'pizza-shop-182a5',
    storageBucket: 'pizza-shop-182a5.appspot.com',
    iosClientId: '212673942750-8lu9jautmbfg8b5vlol64cpgrhtei6l9.apps.googleusercontent.com',
    iosBundleId: 'pizza-shop',
  );
}
