import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/screens/recordings/recording_screen.dart';
import 'package:flutter/material.dart';

class AlarmSheetEmpty extends StatefulWidget {
  const AlarmSheetEmpty({super.key});

  @override
  State<AlarmSheetEmpty> createState() => _AlarmSheetEmptyState();
}

class _AlarmSheetEmptyState extends State<AlarmSheetEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_off,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            t.noRecordingsYet,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecordingScreen(),
                ),
              );
            },
            icon: const Icon(Icons.mic_rounded),
            label: Text(t.recordASound),
          ),
        ],
      ),
    );
  }
}
