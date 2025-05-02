import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_state.dart';
import 'package:echo_wake/presentation/screens/alarm/widgets/alarm_error.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/alarm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/alarm/alarm_cubit.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Alarms'),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        centerTitle: true,
      ),
      body: BlocBuilder<AlarmCubit, AlarmState>(
        builder: (context, state) {
          if (state is AlarmLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (state is AlarmError) {
            return AlarmErrorScreen(message: state.message);
          }

          if (state is AlarmLoaded) {
            if (state.alarms.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm_off_rounded,
                      size: 80,
                      color: colorScheme.primary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No alarms set',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap + to add an alarm',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: state.alarms.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final alarmSettings = state.alarms[index];
                return Dismissible(
                  key: Key(alarmSettings.id.toString()),
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: Icon(
                      Icons.delete_rounded,
                      color: colorScheme.onError,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<AlarmCubit>().stopAlarm(alarmSettings.id);
                    HapticFeedback.mediumImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Alarm deleted'),
                        duration: Durations.long2,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _showEditAlarmSheet(context, alarmSettings),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.alarm_rounded,
                                color: colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat(
                                      'h:mm a',
                                    ).format(alarmSettings.dateTime),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '📅${DateFormat('EEEE, MMMM d').format(alarmSettings.dateTime)}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurface.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    alarmSettings.notificationSettings.body,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurface.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add alarm'),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showAddAlarmSheet(BuildContext context) {
    HapticFeedback.lightImpact();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AlarmSheet(),
    );
  }

  void _showEditAlarmSheet(BuildContext context, AlarmSettings alarm) {
    HapticFeedback.lightImpact();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AlarmSheet(existingAlarm: alarm),
    );
  }
}
