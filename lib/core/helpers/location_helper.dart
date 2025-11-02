// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationHelper {
//   static late Position posaion;
//   static StreamSubscription<Position>? streamLocationSubscription;

//   /// Joriy lokatsiyani qaytaradi. Context berilsa alert ko‘rsatadi.
//   static Future<Position?> displayCurrentLocation([
//     BuildContext? context,
//   ]) async {
//     if (await handleLocationPermission(context)) {
//       try {
//         final val = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );
//         posaion = val;
//         return val;
//       } catch (e) {
//         debugPrint('getCurrentPosition error: $e');
//       }
//     }
//     return null;
//   }

//   /// Xizmat/permission flow: service off -> Settings; denied -> request; deniedForever -> App Settings
//   static Future<bool> handleLocationPermission([BuildContext? context]) async {
//     // 1) Service yoqilganmi?
//     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // iOS: App Settings; Android: Location Settings
//       if (context != null) {
//         await _showDialog(
//           context,
//           title: 'Location off',
//           message: 'Joylashuv xizmati o‘chiq. Iltimos, Settings orqali yoqing.',
//           positiveText: 'Open Settings',
//           onPositive: () async {
//             if (Platform.isAndroid) {
//               await Geolocator.openLocationSettings();
//             } else {
//               await Geolocator.openAppSettings();
//             }
//           },
//         );
//       } else {
//         // dialogsiz ham foydalanuvchini Settings-ga olib kirish foydali bo‘ladi
//         if (Platform.isAndroid) {
//           await Geolocator.openLocationSettings();
//         } else {
//           await Geolocator.openAppSettings();
//         }
//       }
//       return false;
//     }

//     // 2) Permission holati
//     var permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       if (context != null) {
//         await _showDialog(
//           context,
//           title: 'Permission required',
//           message:
//               'Joylashuvga ruxsat “Never” qilib qo‘yilgan. Iltimos, App Settings orqali ruxsat bering.',
//           positiveText: 'Open App Settings',
//           onPositive: () async {
//             await Geolocator.openAppSettings();
//           },
//         );
//       } else {
//         await Geolocator.openAppSettings();
//       }
//       return false;
//     }

//     // whileInUse / always / limited => OK
//     return true;
//   }

//   /// Stream bilan yangilab borish. Context berilsa alert ko‘rsatadi.
//   static Future<void> userLocationUpdate([BuildContext? context]) async {
//     if (await handleLocationPermission(context)) {
//       await streamLocationSubscription?.cancel();
//       streamLocationSubscription =
//           Geolocator.getPositionStream(
//             locationSettings: const LocationSettings(
//               accuracy: LocationAccuracy.high,
//             ),
//           ).listen((posation) {
//             posaion = posation;
//             // print(("LOCATION  $posation"));

//             // updateUserLocation(posation.latitude, posation.longitude);
//           });
//     }
//   }

//   static Future<void> dispose() async {
//     await streamLocationSubscription?.cancel();
//     streamLocationSubscription = null;
//   }

//   //--------- Private helpers ---------//
//   static Future<void> _showDialog(
//     BuildContext context, {
//     required String title,
//     required String message,
//     String positiveText = 'OK',
//     VoidCallback? onPositive,
//   }) async {
//     await showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               onPositive?.call();
//             },
//             child: Text(positiveText),
//           ),
//         ],
//       ),
//     );
//   }
// }
