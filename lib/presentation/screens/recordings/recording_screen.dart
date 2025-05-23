import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/empty.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/record_button.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recording_indicator.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recordings_list.dart';
import 'package:echo_wake/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingScreen extends StatelessWidget {
  final bool selectionMode;
  final void Function() needRebuild;

  const RecordingScreen({
    super.key,
    this.selectionMode = false,
    required this.needRebuild,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingsCubit, RecordingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(t.recordings),
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                  needRebuild();
                },
                icon: const Icon(Icons.settings_rounded),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (state.status == RecordingStatus.recording)
                  RecordingIndicator(duration: state.recordingDuration),
                Expanded(
                  child:
                      state.recordings.isEmpty
                          ? EmptyRecordingsView()
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: RecordingsList(selectionMode: selectionMode),
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
                    child: RecordButton(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
