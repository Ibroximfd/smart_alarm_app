// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_alarm_app/logic/blocs/sleep_reminder_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Alarm')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sleep Reminder', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            BlocBuilder<SleepReminderBloc, SleepReminderState>(
              builder: (context, state) {
                String timeText = 'Not set';
                if (state is SleepReminderSet) {
                  timeText = state.time.format(context);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected Time: $timeText',
                      style: theme.textTheme.bodyLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          // ignore: use_build_context_synchronously
                          context.read<SleepReminderBloc>().add(
                            SetSleepTime(picked),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<SleepReminderBloc>().add(
                          CancelSleepReminder(),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
