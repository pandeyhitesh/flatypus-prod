import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatypus/screens/app.dart' show AppScreens;
import 'package:flatypus/services/firestore/chatroom_service.dart';
import 'package:flatypus/state/controllers/selected_page_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationService();

  Future<void> initialize(BuildContext context, WidgetRef ref) async {
    await _messaging.requestPermission();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        _handleNotificationTap(response.payload, context, ref);
      },
    );

    String? token = await _messaging.getToken();
    if (token != null) {
      await _saveTokenToFirestore(token);
    }

    _messaging.onTokenRefresh.listen(_saveTokenToFirestore);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      clog.checkSuccess(
        true,
        'Inside onMessage. message-notification: ${message.notification}',
      );
      clog.checkSuccess(
        true,
        'Inside onMessage. notification-body: ${message.notification?.body}',
      );
      if (message.notification != null) {
        showLocalNotification(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      clog.checkSuccess(
        true,
        'Inside onMessageOpenedApp. message-notification: ${message.notification}',
      );
      if (context.mounted) {
        _handleMessageNavigation(ref, message, context);
      }
    });

    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      clog.checkSuccess(
        true,
        'Inside initialMessage. initialMessage: $initialMessage',
      );
      if (context.mounted) {
        _handleMessageNavigation(ref, initialMessage, context);
      }
    }
  }

  Future<void> _saveTokenToFirestore(String token) async {
    String userId =
        FirebaseAuth.instance.currentUser?.uid ??
        ""; // Replace with FirebaseAuth.instance.currentUser?.uid
    await _firestore.collection('users').doc(userId).update({
      'fcmToken': token,
    });

    // Update token in all houses where this user is a tenant
    // final houseSnapshots = await _firestore
    //     .collection('houses')
    //     .where('users', arrayContains: userId)
    //     .get();
    // for (var doc in houseSnapshots.docs) {
    //   // Optional: Add a tenants subcollection if needed
    //   // await doc.reference.collection('tenants').doc(userId).set({'fcmToken': token}, SetOptions(merge: true));
    // }
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    final data = message.data;
    var body = message.notification?.body;
    final isEncrypted = data['encrypted'] == '1';
    if (isEncrypted) {
      final encryptedText = data["text"];
      final iv = data["iv"];
      final decryptedText = ChatRoomService().decryptMessage(encryptedText, iv);
      body = decryptedText;
    }
    const androidDetails = AndroidNotificationDetails(
      'chat_channel',
      'Chat Notifications',
      channelDescription: 'Notifications for new chat messages',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.messageId.hashCode,
      message.notification?.title,
      body,
      notificationDetails,
      payload: jsonEncode(data),
    );
  }

  void _handleNotificationTap(
    String? payload,
    BuildContext context,
    WidgetRef ref,
  ) {
    print('inside handleNotificationTap: Payload: $payload');
    if (payload == null) return;
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      if (data['route'] == 'chat') {
        _navigateToChat(ref, data, context);
      }
    } catch (e) {
      print('Error parsing notification payload: $e');
    }
  }

  void _handleMessageNavigation(
    WidgetRef ref,
    RemoteMessage message,
    BuildContext context,
  ) {
    if (message.data['type'] == 'chat_message') {
      _navigateToChat(ref, message.data, context);
    }
  }

  void _navigateToChat(
    WidgetRef ref,
    Map<String, dynamic> data,
    BuildContext context,
  ) {
    ref.read(selectedPageProvider.notifier).state = AppScreens.chatroom.index;
  }
}
