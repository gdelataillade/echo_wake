import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/widgets/audio_player_button.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';

class AlarmSheetRecordingList extends StatefulWidget {
  final List<Recording> recordings;
  final Function(Recording) onSelected;
  final Recording? selectedRecording;
  final AudioPlayerService audioPlayerService;

  const AlarmSheetRecordingList({
    super.key,
    required this.recordings,
    required this.onSelected,
    required this.audioPlayerService,
    this.selectedRecording,
  });

  @override
  State<AlarmSheetRecordingList> createState() =>
      _AlarmSheetRecordingListState();
}

class _AlarmSheetRecordingListState extends State<AlarmSheetRecordingList> {
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
      itemCount: widget.recordings.length,
      itemBuilder: (context, index) {
        final recording = widget.recordings[index];
        final isSelected = widget.selectedRecording?.id == recording.id;

        return GestureDetector(
          onTap: () {
            Helper.lightHapticFeedback();
            widget.onSelected(recording);
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1)
                      : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(recording.name),
              subtitle: Text(_formatDuration(recording.duration)),
              trailing: AudioPlayerButton(
                recording: recording,
                audioPlayerService: widget.audioPlayerService,
                onPlaybackStateChanged: () => setState(() {}),
              ),
            ),
          ),
        );
      },
    );
  }
}
