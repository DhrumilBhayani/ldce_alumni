import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(GlobalKey<NavigatorState> navKey) {
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    // initializationSettings for Android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_notification"),
      iOS: initializationSettingsIOS,
    );

    Future<dynamic> onSelectNotification(payload) async {
      print("On tap foreground onSelectNotification");
      print(payload);
      Map jsonPayload = json.decode(payload);
      print('Hello : ' + jsonPayload.toString());
      print(jsonPayload['type']);
      print(jsonPayload['id']);
      if (jsonPayload["type"].toString().toLowerCase().contains('news')) {
        print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        navKey.currentState!
            .pushNamed('single_internet_news_screen', arguments: ScreenArguments(jsonPayload['id']));
      }
      if (jsonPayload["type"].toString().toLowerCase().contains('event') ||
          jsonPayload["type"].toString().toLowerCase().contains('events')) {
        print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        navKey.currentState!
            .pushNamed('single_internet_events_screen', arguments: ScreenArguments(jsonPayload['id']));
      }
    }

    /// TODO initialize method
    _notificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  static void showStaticNotification(int id, String title, body) async {
    try {
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          // "com.example.flutter_push_notification_app",
          "ldce_push_notifications",
          "Miscellaneous",
          importance: Importance.max,
          priority: Priority.high,

          // tag: message.data['image'],
        ),
      );
      await _notificationsPlugin.show(
        id,
        title,
        "",
        notificationDetails,
        payload: "jsonEncode(message.data)",

        //////// In case of DemoScreen //////////////////////////////////////
        // this "id" key and "id" key of passing firebase's data must same
        // payload: message.data["_id"],
        ////////////////////////////////////////////////////////////////////
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // var bigPictureStyleInformation = BigPictureStyleInformation(
      //   DrawableResourceAndroidBitmap(“cover_image”),
      //   largeIcon: DrawableResourceAndroidBitmap(“app_icon”),
      //   contentTitle: ‘Flutter Big Picture Notification Title’,
      //   summaryText: ‘Flutter Big Picture Notification Summary Text’,
      // );
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          // "com.example.flutter_push_notification_app",
          "ldce_push_notifications",
          "Miscellaneous",
          importance: Importance.max,
          priority: Priority.high,

          tag: message.data['image'],
        ),
      );

      /// pop up show

      if (Platform.isAndroid) {
        await _notificationsPlugin.show(
          id,
          message.data['title'],
          "",
          notificationDetails,
          payload: jsonEncode(message.data),
        );
      }
      if (Platform.isIOS) {
        await _notificationsPlugin.show(
          id,
          message.notification?.title,
          "",
          notificationDetails,
          payload: jsonEncode(message.data),
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}

class ScreenArguments {
  final String id;

  ScreenArguments(this.id);
}
