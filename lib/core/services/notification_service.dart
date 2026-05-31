import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart'
as tz;

import 'package:timezone/data/latest.dart'
as tz;

class NotificationService {

  final FirebaseMessaging
  firebaseMessaging =
      FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin
  localNotifications =
  FlutterLocalNotificationsPlugin();

  // =========================
  // INITIALISATION
  // =========================

  Future<void> init() async {

    // =========================
    // PERMISSIONS
    // =========================

    await firebaseMessaging
        .requestPermission();

    // =========================
    // TIMEZONE
    // =========================

    tz.initializeTimeZones();

    // =========================
    // TOKEN FIREBASE
    // =========================

    String? token =
    await firebaseMessaging
        .getToken();

    print(
      'FCM TOKEN: $token',
    );

    // =========================
    // CONFIGURATION ANDROID
    // =========================

    const androidSettings =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
    InitializationSettings(
      android: androidSettings,
    );

    await localNotifications
        .initialize(settings);

    // =========================
    // ECOUTE FIREBASE
    // =========================

    FirebaseMessaging.onMessage
        .listen((message) {

      showNotification(

        title:
        message.notification
            ?.title ??
            '',

        body:
        message.notification
            ?.body ??
            '',
      );
    });

    // =========================
    // TEST
    // =========================

    await showNotification(

      title: 'CampusPulse',

      body:
      'Notifications activées',
    );
  }

  // =========================
  // NOTIFICATION IMMEDIATE
  // =========================

  Future<void> showNotification({

    required String title,

    required String body,

  }) async {

    const androidDetails =
    AndroidNotificationDetails(

      'campus_channel',

      'Campus Notifications',

      importance:
      Importance.max,

      priority:
      Priority.high,
    );

    const details =
    NotificationDetails(

      android: androidDetails,
    );

    await localNotifications.show(

      DateTime.now()
          .millisecondsSinceEpoch ~/ 1000,

      title,

      body,

      details,
    );
  }

  // =========================
  // NOTIFICATION PROGRAMMEE
  // =========================

  Future<void> scheduleNotification({

    required String title,

    required String body,

    required DateTime scheduledDate,

  }) async {

    // =========================
    // ID UNIQUE
    // =========================

    final notificationId =

        scheduledDate
            .millisecondsSinceEpoch ~/ 1000;

    // =========================
    // DEBUG
    // =========================

    print(
      'Notification prévue pour : '
          '$scheduledDate',
    );

    // =========================
    // PROGRAMMATION
    // =========================

    await localNotifications
        .zonedSchedule(

      notificationId,

      title,

      body,

      tz.TZDateTime.from(
        scheduledDate,
        tz.local,
      ),

      const NotificationDetails(

        android:
        AndroidNotificationDetails(

          'course_channel',

          'Course Notifications',

          importance:
          Importance.max,

          priority:
          Priority.high,
        ),
      ),

      androidScheduleMode:

      AndroidScheduleMode
          .exactAllowWhileIdle,


    );

    print(
      'Notification programmée avec succès',
    );
  }
}