import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/empty_recordings_view.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/record_button.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recording_indicator.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recordings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingScreen extends StatelessWidget {
  final bool selectionMode;

  const RecordingScreen({super.key, this.selectionMode = false});

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
    return BlocBuilder<RecordingsCubit, RecordingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Voice Recordings'),
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (state.status == RecordingStatus.recording)
                  RecordingIndicator(duration: state.recordingDuration),
                Expanded(
                  child:
                      state.recordings.isEmpty
                          ? const EmptyRecordingsView()
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: RecordingsList(
                              recordings: state.recordings,
                              selectionMode: selectionMode,
                            ),
                          ),
                ),
                if (state.status != RecordingStatus.recording)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: const RecordButton(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
