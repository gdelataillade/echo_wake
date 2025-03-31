import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_bloc.dart';
import 'package:echo_wake/presentation/screens/recordings/recording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAlarmSheet extends StatefulWidget {
  const AddAlarmSheet({super.key});

  @override
  State<AddAlarmSheet> createState() => _AddAlarmSheetState();
}

class _AddAlarmSheetState extends State<AddAlarmSheet> {
  late TimeOfDay selectedTime;
  Recording? selectedRecording;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.fromDateTime(
      DateTime.now().add(const Duration(minutes: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set alarm time',
              style: Theme.of(context).textTheme.titleLarge,
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
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
            const SizedBox(height: 16),
            Text(
              'Select alarm sound',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final recording = await Navigator.push<Recording>(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const RecordingScreen(selectionMode: true),
                  ),
                );
                if (recording != null) {
                  setState(() {
                    selectedRecording = recording;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        selectedRecording?.name ?? 'Select a voice recording',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                  onPressed:
                      selectedRecording == null
                          ? null
                          : () {
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

                            context.read<AlarmBloc>().add(
                              CreateAlarm(
                                dateTime: selectedDate,
                                recordingPath: selectedRecording!.path,
                                recordingName: selectedRecording!.name,
                              ),
                            );
                            Navigator.pop(context);
                          },
                  child: const Text('Set alarm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
