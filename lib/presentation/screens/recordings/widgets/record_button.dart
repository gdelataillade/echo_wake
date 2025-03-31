import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton.icon(
        onPressed: () => {context.read<RecordingsBloc>().add(StartRecording())},
        icon: const Icon(Icons.mic),
        label: const Text('Start Recording'),
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
      ),
    );
  }
}
