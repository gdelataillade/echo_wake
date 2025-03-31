import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAlarmSheet extends StatelessWidget {
  final AlarmSettings alarm;

  const EditAlarmSheet({super.key, required this.alarm});

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTime = TimeOfDay(
      hour: alarm.dateTime.hour,
      minute: alarm.dateTime.minute,
    );

    return StatefulBuilder(
      builder:
          (context, setState) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit alarm',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<AlarmBloc>().add(DeleteAlarm(alarm.id));
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                        initialEntryMode: TimePickerEntryMode.dialOnly,
                      );
                      if (time != null) {
                        setState(() => selectedTime = time);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            selectedTime.format(context),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          final now = DateTime.now();
                          DateTime selectedDate = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );

                          if (selectedDate.isBefore(now)) {
                            selectedDate = selectedDate.add(
                              const Duration(days: 1),
                            );
                          }

                          // Delete the old alarm and create a new one
                          context.read<AlarmBloc>().add(DeleteAlarm(alarm.id));
                          context.read<AlarmBloc>().add(
                            CreateAlarm(
                              dateTime: selectedDate,
                              recordingPath: alarm.assetAudioPath,
                              recordingName:
                                  alarm.notificationSettings.body.split('"')[1],
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: const Text('Save changes'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
