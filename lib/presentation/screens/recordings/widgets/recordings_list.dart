import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/rename_recording_dialog.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recording_item.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingsList extends StatelessWidget {
  final List<Recording> recordings;
  final bool selectionMode;

  const RecordingsList({
    super.key,
    required this.recordings,
    required this.selectionMode,
  });

  Future<void> _showRenameDialog(
    BuildContext context,
    Recording recording,
  ) async {
    return showDialog(
      context: context,
      builder:
          (context) => RenameRecordingDialog(
            recording: recording,
            recordings: recordings,
          ),
    );
  }

  Future<void> _deleteRecording(
    BuildContext context,
    Recording recording,
  ) async {
    final bloc = context.read<RecordingsCubit>();
    bloc.deleteRecording(recording);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recordings.length,
      itemBuilder: (context, index) {
        final recording = recordings[index];
        return Dismissible(
          key: Key(recording.id),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onError,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _deleteRecording(context, recording);
            HapticFeedback.mediumImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Recording deleted'),
                duration: Durations.long2,
              ),
            );
          },
          child: RecordingItem(
            recording: recording,
            audioPlayerService: AudioPlayerService(),
            onSelect: (recording) => _showRenameDialog(context, recording),
            selectionMode: selectionMode,
          ),
        );
      },
    );
  }
}
