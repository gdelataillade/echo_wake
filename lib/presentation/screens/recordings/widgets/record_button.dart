import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
                context.read<RecordingsCubit>().startRecording();
              },
              icon: const Icon(Icons.mic, size: 20),
              label: const Text('Start Recording'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 55,
            height: 55,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                context.read<RecordingsCubit>().importAudioFile();
              },
              icon: const Icon(Icons.upload_file_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
