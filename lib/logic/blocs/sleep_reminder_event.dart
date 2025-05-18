// lib/logic/blocs/sleep_reminder/sleep_reminder_event.dart
part of 'sleep_reminder_bloc.dart';

abstract class SleepReminderEvent extends Equatable {
  const SleepReminderEvent();
  @override
  List<Object?> get props => [];
}

class SetSleepTime extends SleepReminderEvent {
  final TimeOfDay time;
  const SetSleepTime(this.time);
  @override
  List<Object?> get props => [time];
}

class CancelSleepReminder extends SleepReminderEvent {}

class LoadSleepReminder extends SleepReminderEvent {}
