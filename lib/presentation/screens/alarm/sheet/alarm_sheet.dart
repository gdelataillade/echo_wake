import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/empty.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/alarm_recording_list.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/notification_permission_sheet.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/open_notification_settings_sheet.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/widgets/time_picker.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

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

  Future<void> _submit() async {
    Helper.hapticFeedback();

    PermissionStatus status = await Permission.notification.status;

    if (status != PermissionStatus.granted) {
      if (status == PermissionStatus.denied) {
        if (!mounted) return;
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (context) => const AlarmNotificationPermissionSheet(),
        );
        status = await Permission.notification.status;
      }

      if (status.isDeniedOrPermanentlyDenied) {
        if (!mounted) return;
        final ignored = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          builder: (context) => const OpenNotificationSettingsSheet(),
        );

        if (ignored ?? true) return;
      }
    }

    setState(() => isLoading = true);

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

    if (!mounted) return;
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

  Future<TimeOfDay?> pickTime(
    BuildContext context,
    TimeOfDay initialTime,
  ) async {
    if (Platform.isIOS) {
      TimeOfDay? pickedTime;
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          DateTime now = DateTime.now();
          DateTime initialDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            initialTime.hour,
            initialTime.minute,
          );
          DateTime tempPicked = initialDateTime;
          return Container(
            height: 300,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                SizedBox(
                  height: 216,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: initialDateTime,
                    use24hFormat: MediaQuery.of(context).alwaysUse24HourFormat,
                    onDateTimeChanged: (DateTime newDateTime) {
                      tempPicked = newDateTime;
                    },
                  ),
                ),
                CupertinoButton(
                  child: Text('OK'),
                  onPressed: () {
                    pickedTime = TimeOfDay(
                      hour: tempPicked.hour,
                      minute: tempPicked.minute,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
      return pickedTime;
    } else {
      return showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.dialOnly,
      );
    }
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

        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEditMode ? t.editAlarm : t.setAlarmTime,
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
                        Helper.hapticFeedback();

                        final time = await pickTime(context, selectedTime);
                        if (time != null) {
                          setState(() => selectedTime = time);
                        }
                      },
                      child: AlarmSheetTimePicker(selectedTime: selectedTime),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.selectAlarmSound,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
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
                      title: Text(t.loopSound),
                      subtitle: Text(t.playSoundRepeatedlyUntilAlarmStopped),
                      value: isLoopEnabled,
                      onChanged: (value) {
                        setState(() {
                          isLoopEnabled = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(t.customVolume),
                      subtitle: Text(t.setSpecificVolumeForThisAlarm),
                      value: isCustomVolumeEnabled,
                      onChanged: (value) {
                        Helper.hapticFeedback();
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
                          Helper.hapticFeedback();
                          setState(() {
                            alarmVolume = value;
                          });
                        },
                        divisions: 10,
                        label: '${(alarmVolume * 100).round()}%',
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(t.cancel),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: selectedRecording == null ? null : _submit,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isLoading)
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                )
                              else
                                Text(isEditMode ? t.saveChanges : t.setAlarm),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
