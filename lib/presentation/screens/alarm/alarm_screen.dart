import 'package:alarm/model/alarm_settings.dart';
import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_state.dart';
import 'package:echo_wake/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:echo_wake/presentation/screens/alarm/widgets/alarm_error.dart';
import 'package:echo_wake/presentation/screens/alarm/sheet/alarm_sheet.dart';
import 'package:echo_wake/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/alarm/alarm_cubit.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatelessWidget {
  final void Function() needRebuild;

  const AlarmScreen({super.key, required this.needRebuild});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(t.alarms),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              needRebuild();
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
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
                      t.noAlarms,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.tapPlusToAddAlarm,
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
                    Helper.vibrateHapticFeedback();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.alarmDeleted),
                        duration: const Duration(seconds: 2),
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

          return Center(child: Text(t.noAlarms));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAlarmSheet(context),
        icon: const Icon(Icons.add_rounded),
        label: Text(t.addAlarm),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Future<void> _showAddAlarmSheet(BuildContext context) async {
    Helper.lightHapticFeedback();

    final res = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => AlarmSheet(),
    );

    if (context.mounted && res != null && res == true) {
      context.read<NavigationCubit>().updateSelectedTab(1);
    }
  }

  void _showEditAlarmSheet(BuildContext context, AlarmSettings alarm) {
    Helper.lightHapticFeedback();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AlarmSheet(existingAlarm: alarm),
    );
  }
}
