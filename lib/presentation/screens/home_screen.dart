import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/screens/ring_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'alarm/alarm_screen.dart';
import 'recordings/recording_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static StreamSubscription<AlarmSet>? ringSubscription;

  @override
  void initState() {
    ringSubscription ??= Alarm.ringing.listen(ringingAlarmsChanged);
    super.initState();
  }

  Future<void> ringingAlarmsChanged(AlarmSet alarms) async {
    if (alarms.alarms.isEmpty) return;
    final ringingAlarm = alarms.alarms.first;
    print(ringingAlarm.toString());

    if (ringingAlarm.payload == null) return;

    final recording = await context.read<RecordingsCubit>().getRecordingById(
      ringingAlarm.payload!,
    );

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RingScreen(alarm: ringingAlarm, recording: recording),
      ),
    );

    unawaited(context.read<AlarmCubit>().loadAlarms());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body:
              [const AlarmScreen(), const RecordingScreen()][state.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedTab,
            onTap: (index) {
              HapticFeedback.lightImpact();
              context.read<NavigationCubit>().updateSelectedTab(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarms'),
              BottomNavigationBarItem(
                icon: Icon(Icons.mic),
                label: 'Recordings',
              ),
            ],
          ),
        );
      },
    );
  }
}
