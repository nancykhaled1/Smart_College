// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class NotificationPermissionHelper {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//   /// طلب الإذن بالنوتيفيكيشن
//   static Future<void> requestNotificationPermission(BuildContext context) async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint("✅ User granted permission");
//     } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
//       debugPrint("❌ User denied permission");
//       _showPermissionDialog(context);
//     } else {
//       debugPrint("⚠️ Permission status: ${settings.authorizationStatus}");
//     }
//   }
//
//   /// فتح الـ Settings في حالة الرفض
//   static void _showPermissionDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("تنبيه"),
//         content: Text("الإشعارات مقفولة. هل تريد تفعيلها من الإعدادات؟"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("إلغاء"),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await openAppSettings(); // يفتح صفحة الإعدادات للتطبيق
//             },
//             child: Text("فتح الإعدادات"),
//           ),
//         ],
//       ),
//     );
//   }
// }
