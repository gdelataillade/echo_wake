import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/alarm/alarm_bloc.dart';
import 'package:intl/intl.dart';
import '../screens/recordings_screen.dart';

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarms'), elevation: 0),
      body: BlocBuilder<AlarmBloc, AlarmState>(
        builder: (context, state) {
          if (state is AlarmLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AlarmError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is AlarmLoaded) {
            if (state.alarms.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No alarms set',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap + to add an alarm',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.alarms.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final alarmSettings = state.alarms[index];
                return Dismissible(
                  key: Key(alarmSettings.id.toString()),
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<AlarmBloc>().add(
                      DeleteAlarm(alarmSettings.id),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.alarm,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    title: Text(
                      DateFormat('h:mm a').format(alarmSettings.dateTime),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      DateFormat('EEEE, MMMM d').format(alarmSettings.dateTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (value) {
                        if (!value) {
                          context.read<AlarmBloc>().add(
                            StopAlarm(alarmSettings.id),
                          );
                        }
                      },
                    ),
                    onTap: () => _showEditAlarmSheet(context, alarmSettings),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No alarms set'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAlarmSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Add alarm'),
      ),
    );
  }

  void _showAddAlarmSheet(BuildContext context) {
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(
      DateTime.now().add(const Duration(minutes: 1)),
    );
    Recording? selectedRecording;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => StatefulBuilder(
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
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
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
                                    (context) => const RecordingsScreen(
                                      selectionMode: true,
                                    ),
                              ),
                            );
                            if (recording != null) {
                              setState(() => selectedRecording = recording);
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
                                  Icons.music_note,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    selectedRecording?.name ??
                                        'Select a voice recording',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                                            recordingPath:
                                                selectedRecording!.path,
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
                ),
          ),
    );
  }

  void _showEditAlarmSheet(BuildContext context, AlarmSettings alarm) {
    TimeOfDay selectedTime = TimeOfDay(
      hour: alarm.dateTime.hour,
      minute: alarm.dateTime.minute,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => StatefulBuilder(
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
                                context.read<AlarmBloc>().add(
                                  DeleteAlarm(alarm.id),
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
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
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
                                context.read<AlarmBloc>().add(
                                  DeleteAlarm(alarm.id),
                                );
                                context.read<AlarmBloc>().add(
                                  CreateAlarm(
                                    dateTime: selectedDate,
                                    recordingPath: alarm.assetAudioPath,
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
          ),
    );
  }
}
