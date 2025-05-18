// lib/services/prefs_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static final PrefsService _instance = PrefsService._internal();
  factory PrefsService() => _instance;
  PrefsService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTime(int hour, int minute) async {
    await _prefs.setInt('hour', hour);
    await _prefs.setInt('minute', minute);
  }

  TimeOfDay? getTime() {
    final hour = _prefs.getInt('hour');
    final minute = _prefs.getInt('minute');
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    }
    return null;
  }

  Future<void> clearTime() async {
    await _prefs.remove('hour');
    await _prefs.remove('minute');
  }
}
