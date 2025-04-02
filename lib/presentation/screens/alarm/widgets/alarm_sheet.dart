import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/screens/recordings/recording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmSheet extends StatefulWidget {
  final AlarmSettings? existingAlarm; // null means we're creating a new alarm

  const AlarmSheet({super.key, this.existingAlarm});

  @override
  State<AlarmSheet> createState() => _AlarmSheetState();
}

class _AlarmSheetState extends State<AlarmSheet> {
  late TimeOfDay selectedTime;
  Recording? selectedRecording;
  bool isLoopEnabled = false;
  bool isCustomVolumeEnabled = false;
  double alarmVolume = 1.0;

  @override
  void initState() {
    super.initState();

    if (widget.existingAlarm != null) {
      // Editing mode - initialize with existing alarm values
      selectedTime = TimeOfDay(
        hour: widget.existingAlarm!.dateTime.hour,
        minute: widget.existingAlarm!.dateTime.minute,
      );
      // Find the recording by path from RecordingsBloc state
      final recordings = context.read<RecordingsBloc>().state.recordings;
      try {
        selectedRecording = recordings.firstWhere(
          (recording) =>
              recording.path.contains(widget.existingAlarm!.assetAudioPath),
        );
      } catch (e) {
        selectedRecording = null;
      }
    } else {
      // Creation mode - initialize with default values
      selectedTime = TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.existingAlarm != null;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditMode ? 'Edit alarm' : 'Set alarm time',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (isEditMode)
                  IconButton(
                    onPressed: () {
                      context.read<AlarmBloc>().add(
                        StopAlarm(widget.existingAlarm!.id),
                      );
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Loop audio',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Switch(
                  value: isLoopEnabled,
                  onChanged: (value) => setState(() => isLoopEnabled = value),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Custom volume',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Switch(
                  value: isCustomVolumeEnabled,
                  onChanged:
                      (value) => setState(() => isCustomVolumeEnabled = value),
                ),
              ],
            ),
            if (isCustomVolumeEnabled) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.volume_down,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Slider(
                      value: alarmVolume,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) => setState(() => alarmVolume = value),
                    ),
                  ),
                  Icon(
                    Icons.volume_up,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),

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
                          : () async {
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

                            if (isEditMode) {
                              // Delete the old alarm first
                              context.read<AlarmBloc>().add(
                                StopAlarm(widget.existingAlarm!.id),
                              );
                              Future.delayed(
                                const Duration(milliseconds: 1000),
                              );
                            }

                            // Create new alarm
                            context.read<AlarmBloc>().add(
                              CreateAlarm(
                                dateTime: selectedDate,
                                recordingPath: selectedRecording!.path,
                                recordingName: selectedRecording!.name,
                                loopAudio: isLoopEnabled,
                                volume:
                                    isCustomVolumeEnabled ? alarmVolume : null,
                              ),
                            );
                            Navigator.pop(context);
                          },
                  child: Text(isEditMode ? 'Save changes' : 'Set alarm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
