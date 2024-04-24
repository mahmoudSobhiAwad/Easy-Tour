import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPNe5yIhsxj3omND-GsTuBa2ZsUjTPeZw',
    appId: '1:557986453769:android:ade98f1f5493d6abfb5bd8',
    messagingSenderId: '557986453769',
    projectId: 'graduationproject-f494b',
    storageBucket: 'graduationproject-f494b.appspot.com',
  );

}