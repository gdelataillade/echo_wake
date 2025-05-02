import 'package:alarm/alarm.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RingScreen extends StatefulWidget {
  final AlarmSettings alarm;
  final Recording recording;

  const RingScreen({super.key, required this.alarm, required this.recording});

  @override
  State<RingScreen> createState() => _RingScreenState();
}

class _RingScreenState extends State<RingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Icon(
                    Icons.alarm,
                    size: 80,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Your alarm is ringing',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: .5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.music_note, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          widget.recording.name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                FilledButton.icon(
                  onPressed: () async {
                    await context.read<AlarmCubit>().stopAlarm(widget.alarm.id);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop Alarm'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
