import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parcial_moviles/views/home.dart';
import 'package:parcial_moviles/views/login.dart';

late String fcm;

void handleMessage(RemoteMessage msg) {
  print("Title: ${msg.notification!.title}");
  print("Body: ${msg.notification!.body}");
}

Future<void> handleMessageBg(RemoteMessage msg) async {
  print("Title: ${msg.notification!.title}");
  print("Body: ${msg.notification!.body}");
}

Future<void> setupFirebaseListener() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(handleMessageBg);
  FirebaseMessaging.onMessage.listen(handleMessage);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  messaging.getToken().then((value) {
    if (value == null) throw Exception("FCM is null");
    fcm = value;
  });
}
