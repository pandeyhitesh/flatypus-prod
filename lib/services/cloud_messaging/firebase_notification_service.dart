// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flatypus/models/house_model.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class FirebaseNotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
//
//   Future<void> initNotifications() async {
//     // Request permission for notifications
//     await _firebaseMessaging.requestPermission();
//
//     // Initialize Local Notifications
//     const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
//     await _localNotifications.initialize(initSettings);
//
//     // Get FCM Token
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//
//     // Handle Foreground Messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showNotification(message.notification?.title ?? "New Notification",
//           message.notification?.body ?? "You have a new update");
//     });
//   }
//
//   // Show local notification
//   Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails('channel_id', 'channel_name', importance: Importance.high);
//     const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
//
//     await _localNotifications.show(0, title, body, platformDetails);
//   }
//
//   Future<void> updateUserFCMToken(String? userId) async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     if (token != null) {
//       await FirebaseFirestore.instance.collection('users').doc(userId).update({'fcmToken': token});
//     }
//   }
//
//   Future<void> sendPushNotificationToHouseMembers(HouseModel house) async {
//     for (var user in house.users??[]) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.id).get();
//       String? fcmToken = userDoc['fcmToken'];
//
//       if (fcmToken != null) {
//         await FirebaseMessaging.instance.sendMessage(
//           to: fcmToken,
//           data: {
//             'title': 'New Member Joined!',
//             'body': '${house.displayName} has a new member!',
//           },
//         );
//       }
//     }
//   }
//
// }
