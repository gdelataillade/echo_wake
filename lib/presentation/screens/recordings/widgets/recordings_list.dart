import 'package:audioplayers/audioplayers.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/rename_recording_dialog.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recording_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingsList extends StatefulWidget {
  final List<Recording> recordings;
  final bool selectionMode;

  const RecordingsList({
    super.key,
    required this.recordings,
    required this.selectionMode,
  });

  @override
  State<RecordingsList> createState() => _RecordingsListState();
}

class _RecordingsListState extends State<RecordingsList> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _playingRecordingId;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _playingRecordingId = null;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback(Recording recording) async {
    HapticFeedback.lightImpact();

    if (_playingRecordingId == recording.id) {
      await _audioPlayer.pause();
      setState(() {
        _playingRecordingId = null;
      });
    } else {
      if (_playingRecordingId != null) {
        await _audioPlayer.stop();
      }
      final fullPath = await recording.getFullPath();
      try {
        await _audioPlayer.play(DeviceFileSource(fullPath));
        setState(() {
          _playingRecordingId = recording.id;
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to play recording: ${e.toString()}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  Future<void> _showRenameDialog(
    BuildContext context,
    Recording recording,
  ) async {
    return showDialog(
      context: context,
      builder:
          (context) => RenameRecordingDialog(
            recording: recording,
            recordings: widget.recordings,
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
      itemCount: widget.recordings.length,
      itemBuilder: (context, index) {
        final recording = widget.recordings[index];
        final isPlaying = _playingRecordingId == recording.id;
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
            isPlaying: isPlaying,
            onTogglePlayback: _togglePlayback,
            onSelect: (recording) => _showRenameDialog(context, recording),
            selectionMode: widget.selectionMode,
          ),
        );
      },
    );
  }
}
