// lib/logic/blocs/sleep_reminder/sleep_reminder_bloc.dart
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sleep_reminder_event.dart';
part 'sleep_reminder_state.dart';

class SleepReminderBloc extends Bloc<SleepReminderEvent, SleepReminderState> {
  SleepReminderBloc() : super(SleepReminderInitial()) {
    on<SetSleepTime>(_onSetSleepTime);
    on<CancelSleepReminder>(_onCancelReminder);
    on<LoadSleepReminder>(_onLoadReminder);
  }

  Future<void> _onSetSleepTime(SetSleepTime event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sleep_hour', event.time.hour);
    await prefs.setInt('sleep_minute', event.time.minute);
    emit(SleepReminderSet(event.time));
  }

  Future<void> _onCancelReminder(
    CancelSleepReminder event,
    Emitter emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sleep_hour');
    await prefs.remove('sleep_minute');
    emit(SleepReminderCanceled());
  }

  Future<void> _onLoadReminder(LoadSleepReminder event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt('sleep_hour');
    final minute = prefs.getInt('sleep_minute');
    if (hour != null && minute != null) {
      emit(SleepReminderSet(TimeOfDay(hour: hour, minute: minute)));
    } else {
      emit(SleepReminderInitial());
    }
  }
}
