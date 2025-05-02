import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/empty.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/alarm_recording_list.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/time_picker.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmSheet extends StatefulWidget {
  final AlarmSettings? existingAlarm;

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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.existingAlarm != null) {
      // Editing mode - initialize with existing alarm values
      selectedTime = TimeOfDay(
        hour: widget.existingAlarm!.dateTime.hour,
        minute: widget.existingAlarm!.dateTime.minute,
      );
      isLoopEnabled = widget.existingAlarm!.loopAudio;
    } else {
      // Creation mode - initialize with default values
      selectedTime = TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 1)),
      );
    }
  }

  Future<void> submit() async {
    HapticFeedback.lightImpact();

    setState(() {
      isLoading = true;
    });

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (dateTime.isBefore(now)) {
      dateTime.add(const Duration(days: 1));
    }

    await context.read<AlarmCubit>().createAlarm(
      dateTime: dateTime,
      recordingId: selectedRecording!.id,
      recordingPath: selectedRecording!.filename,
      recordingName: selectedRecording!.name,
      loopAudio: isLoopEnabled,
      volume: isCustomVolumeEnabled ? alarmVolume : null,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.existingAlarm != null;

    return BlocBuilder<RecordingsCubit, RecordingsState>(
      builder: (context, state) {
        if (isEditMode &&
            selectedRecording == null &&
            state.recordings.isNotEmpty) {
          try {
            selectedRecording = state.recordings.firstWhere(
              (recording) => recording.filename.contains(
                widget.existingAlarm!.assetAudioPath,
              ),
            );
          } catch (e) {
            selectedRecording = null;
          }
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
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
                          context.read<AlarmCubit>().stopAlarm(
                            widget.existingAlarm!.id,
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
                    HapticFeedback.lightImpact();

                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                      initialEntryMode: TimePickerEntryMode.dialOnly,
                    );
                    if (time != null) {
                      setState(() => selectedTime = time);
                    }
                  },
                  child: AlarmSheetTimePicker(selectedTime: selectedTime),
                ),
                const SizedBox(height: 16),
                Text(
                  'Select alarm sound',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      state.recordings.isEmpty
                          ? const AlarmSheetEmpty()
                          : AlarmSheetRecordingList(
                            recordings: state.recordings,
                            selectedRecording: selectedRecording,
                            audioPlayerService: AudioPlayerService(),
                            onSelected: (recording) {
                              setState(() => selectedRecording = recording);
                            },
                          ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Loop sound'),
                  subtitle: const Text(
                    'Play the sound repeatedly until the alarm is stopped',
                  ),
                  value: isLoopEnabled,
                  onChanged: (value) {
                    setState(() {
                      isLoopEnabled = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Custom volume'),
                  subtitle: const Text('Set a specific volume for this alarm'),
                  value: isCustomVolumeEnabled,
                  onChanged: (value) {
                    HapticFeedback.lightImpact();
                    setState(() {
                      isCustomVolumeEnabled = value;
                    });
                  },
                ),
                if (isCustomVolumeEnabled) ...[
                  const SizedBox(height: 8),
                  Slider(
                    value: alarmVolume,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        alarmVolume = value;
                      });
                    },
                    divisions: 10,
                    label: '${(alarmVolume * 100).round()}%',
                  ),
                ],
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: selectedRecording == null ? null : submit,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isLoading)
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            )
                          else
                            Text(isEditMode ? 'Save changes' : 'Set alarm'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
