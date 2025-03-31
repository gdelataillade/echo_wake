import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_event.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingsScreen extends StatelessWidget {
  final bool selectionMode;

  const RecordingsScreen({super.key, this.selectionMode = false});

  @override
  Widget build(BuildContext context) {
    return RecordingsView(selectionMode: selectionMode);
  }
}

class RecordingsView extends StatelessWidget {
  final bool selectionMode;

  const RecordingsView({super.key, this.selectionMode = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingsBloc, RecordingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Voice Recordings'), elevation: 0),
          body: Column(
            children: [
              if (state.status == RecordingStatus.recording)
                RecordingIndicator(duration: state.recordingDuration),
              Expanded(
                child:
                    state.recordings.isEmpty
                        ? const EmptyRecordingsView()
                        : RecordingsList(
                          recordings: state.recordings,
                          selectionMode: selectionMode,
                        ),
              ),
              if (state.status != RecordingStatus.recording) RecordButton(),
            ],
          ),
        );
      },
    );
  }
}

class RecordingIndicator extends StatelessWidget {
  final Duration duration;

  const RecordingIndicator({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mic,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                _formatDuration(duration),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.close),
                label: const Text('Cancel'),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
              FilledButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.stop),
                label: const Text('Stop'),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }
}

class EmptyRecordingsView extends StatelessWidget {
  const EmptyRecordingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_none,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No recordings yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class RecordingsList extends StatelessWidget {
  final List<Recording> recordings;
  final bool selectionMode;

  const RecordingsList({
    super.key,
    required this.recordings,
    required this.selectionMode,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recordings.length,
      itemBuilder: (context, index) {
        final recording = recordings[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(
              recording.name,
              style: Theme.of(context).textTheme.titleMedium,
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
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () async {
                    final audioPlayer = AudioPlayer();
                    await audioPlayer.play(DeviceFileSource(recording.path));
                  },
                ),
                if (!selectionMode) ...[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showRenameDialog(context, recording),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteRecording(context, recording),
                  ),
                ],
                if (selectionMode)
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
            onTap:
                selectionMode ? () => Navigator.pop(context, recording) : null,
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
                  final index = recordings.indexWhere(
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

class RecordButton extends StatelessWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton.icon(
        onPressed: () => {},
        icon: const Icon(Icons.mic),
        label: const Text('Start Recording'),
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
      ),
    );
  }
}
