// lib/logic/blocs/sleep_reminder/sleep_reminder_state.dart
part of 'sleep_reminder_bloc.dart';

abstract class SleepReminderState extends Equatable {
  const SleepReminderState();
  @override
  List<Object?> get props => [];
}

class SleepReminderInitial extends SleepReminderState {}

class SleepReminderSet extends SleepReminderState {
  final TimeOfDay time;
  const SleepReminderSet(this.time);
  @override
  List<Object?> get props => [time];
}

class SleepReminderCanceled extends SleepReminderState {}
