import 'package:audioplayers/audioplayers.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_event.dart';
import 'package:flutter/material.dart';
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
    if (_playingRecordingId == recording.id) {
      await _audioPlayer.pause();
      setState(() {
        _playingRecordingId = null;
      });
    } else {
      if (_playingRecordingId != null) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(DeviceFileSource(recording.path));
      setState(() {
        _playingRecordingId = recording.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.recordings.length,
      itemBuilder: (context, index) {
        final recording = widget.recordings[index];
        final isPlaying = _playingRecordingId == recording.id;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(
              recording.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              '${recording.duration.inMinutes}:${(recording.duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.audio_file,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () => _togglePlayback(recording),
                ),
                if (!widget.selectionMode) ...[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showRenameDialog(context, recording),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteRecording(context, recording),
                  ),
                ],
                if (widget.selectionMode)
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
            onTap:
                widget.selectionMode
                    ? () => Navigator.pop(context, recording)
                    : null,
          ),
        );
      },
    );
  }

  Future<void> _showRenameDialog(
    BuildContext context,
    Recording recording,
  ) async {
    final nameController = TextEditingController(text: recording.name);
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Rename Recording'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'New Name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final index = widget.recordings.indexWhere(
                    (r) => r.id == recording.id,
                  );
                  if (index != -1) {
                    final updatedRecording = recording.copyWith(
                      name: nameController.text,
                    );
                    final bloc = context.read<RecordingsBloc>();
                    bloc.add(
                      UpdateRecordingName(
                        updatedRecording,
                        nameController.text,
                      ),
                    );
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  Future<void> _deleteRecording(
    BuildContext context,
    Recording recording,
  ) async {
    final bloc = context.read<RecordingsBloc>();
    bloc.add(DeleteRecording(recording));
  }
}
