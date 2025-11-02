// import 'dart:ui';
// import 'dart:math';
// import 'firebase_options.dart';

// class FireBaseApi {
//   static Future<void> initFirebaseMessaging() async {
//     try {
//       //Init Locla Notification
//       await NotificationService().initNotification();

//       // Init FireBase
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );

//       FlutterError.onError = (errorDetails) {
//         FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
//       };
//       PlatformDispatcher.instance.onError = (error, stack) {
//         FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//         return true;
//       };
//       setupInteractedMessage();

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         // print("FIRE DATA :${message.data}\n");
//       });
//     } catch (e) {
//       debugPrint("FIRABSE. ERROR: $e");
//     }
//   }

//   static Future<void> setupInteractedMessage() async {
//     RemoteMessage? initialMessage = await FirebaseMessaging.instance
//         .getInitialMessage();

//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }

//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }

//   static void _handleMessage(RemoteMessage message) {
//     print("FIRE BACKGRAUND DATA :${message.data}");
//   }
// }
