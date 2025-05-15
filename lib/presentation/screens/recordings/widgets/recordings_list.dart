import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/rename_recording_dialog.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/recording_item.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingsList extends StatelessWidget {
  final bool selectionMode;

  const RecordingsList({super.key, required this.selectionMode});

  Future<void> _showRenameDialog(
    BuildContext context,
    Recording recording,
    List<Recording> recordings,
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

  Future<bool> _canDeleteRecording(
    BuildContext context,
    Recording recording,
  ) async {
    final alarms = await context.read<AlarmCubit>().getAlarms();
    return !alarms.any((alarm) => alarm.payload == recording.id);
  }

  Future<bool> _confirmDeleteRecording(
    BuildContext context,
    Recording recording,
  ) async {
    final canDelete = await _canDeleteRecording(context, recording);
    if (context.mounted && !canDelete) {
      Helper.vibrateHapticFeedback();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(t.cannotDeleteRecordingLinkedToAlarm),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _deleteRecording(
    BuildContext context,
    Recording recording,
  ) async {
    final bloc = context.read<RecordingsCubit>();
    bloc.deleteRecording(recording);

    Helper.mediumHapticFeedback();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.recordingDeleted), duration: Durations.long3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingsCubit, RecordingsState>(
      builder: (context, state) {
        final recordings = state.recordings;
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
              confirmDismiss:
                  (_) => _confirmDeleteRecording(context, recording),
              onDismissed: (_) => _deleteRecording(context, recording),
              child: RecordingItem(
                recording: recording,
                audioPlayerService: AudioPlayerService(),
                onSelect:
                    (recording) =>
                        _showRenameDialog(context, recording, recordings),
                selectionMode: selectionMode,
              ),
            );
          },
        );
      },
    );
  }
}
