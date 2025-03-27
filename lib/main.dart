import 'dart:developer';

import 'package:chat_app/services/colud_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Notifications.notifications.permission();
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  log(token ?? "");
  runApp(
    const ChatApp(),
  );
}
