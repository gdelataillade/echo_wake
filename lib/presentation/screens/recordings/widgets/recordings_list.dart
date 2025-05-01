import 'package:audioplayers/audioplayers.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
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
      await _audioPlayer.play(DeviceFileSource(fullPath));
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
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: GestureDetector(
                onTap: () => _showRenameDialog(context, recording),
                child: Text(
                  recording.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              subtitle: GestureDetector(
                onTap: () => _showRenameDialog(context, recording),
                child: Text(
                  '${recording.duration.inMinutes}:${(recording.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: IconButton(
                  onPressed: () => _togglePlayback(recording),
                  icon: Icon(
                    Icons.audio_file,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => _togglePlayback(recording),
                    ),
                  ),
                  if (widget.selectionMode) ...[
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () => Navigator.pop(context, recording),
                      ),
                    ),
                  ],
                ],
              ),
              onTap:
                  widget.selectionMode
                      ? () => Navigator.pop(context, recording)
                      : null,
            ),
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
                    final bloc = context.read<RecordingsCubit>();
                    bloc.updateRecordingName(nameController.text);
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
    final bloc = context.read<RecordingsCubit>();
    bloc.deleteRecording(recording);
  }
}
