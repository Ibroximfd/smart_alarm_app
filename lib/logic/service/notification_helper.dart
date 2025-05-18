// lib/services/notification_helper.dart
import 'dart:developer';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await AndroidAlarmManager.initialize();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleAlarm(TimeOfDay time) async {
    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final adjusted =
        alarmTime.isBefore(now)
            ? alarmTime.add(const Duration(days: 1))
            : alarmTime;
    final id = 101;

    await AndroidAlarmManager.oneShotAt(
      adjusted,
      id,
      _alarmCallback,
      exact: true,
      wakeup: true,
    );
    log('Alarm scheduled at $adjusted');
  }

  static Future<void> _alarmCallback() async {
    // Here you can show a notification or launch the app
    log('Alarm triggered!');
  }
}
