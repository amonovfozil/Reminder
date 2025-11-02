// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//         'you can reconfigure this by running the FlutterFire CLI again.',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyDqk6LXl1B9-MwbKUZp1v3klskt1LFP0vo',
//     appId: '1:873655837498:android:dd2cfa3f9a43e2487fe603',
//     messagingSenderId: '873655837498',
//     projectId: 'paramedics-e04dc',
//     storageBucket: 'paramedics-e04dc.firebasestorage.app',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyDHP5u_lYWq_s_Sg34vZKUgo5-w2lPeaLA',
//     appId: '1:873655837498:ios:cdd74187fbd0c4e37fe603',
//     messagingSenderId: '873655837498',
//     projectId: 'paramedics-e04dc',
//     storageBucket: 'paramedics-e04dc.firebasestorage.app',
//     iosBundleId: 'com.paramedicsuz.paramedics',
//   );
// }
