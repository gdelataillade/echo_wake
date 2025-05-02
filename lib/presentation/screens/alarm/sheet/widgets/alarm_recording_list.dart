import 'package:echo_wake/data/models/recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmSheetRecordingList extends StatelessWidget {
  final List<Recording> recordings;
  final Function(Recording) onSelected;
  final Recording? selectedRecording;

  const AlarmSheetRecordingList({
    super.key,
    required this.recordings,
    required this.onSelected,
    this.selectedRecording,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recordings.length,
      itemBuilder: (context, index) {
        final recording = recordings[index];
        final isSelected = selectedRecording?.id == recording.id;

        return ListTile(
          leading: Icon(
            Icons.mic,
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
          ),
          title: Text(
            recording.name,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(_formatDuration(recording.duration)),
          trailing:
              isSelected
                  ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                  : null,
          onTap: () {
            HapticFeedback.lightImpact();
            onSelected(recording);
          },
        );
      },
    );
  }
}
