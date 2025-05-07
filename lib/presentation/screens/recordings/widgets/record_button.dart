import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:echo_wake/presentation/screens/recordings/widgets/microphone_permission_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key});

  Future<void> _onPressRecord(BuildContext context) async {
    Helper.hapticFeedback();

    PermissionStatus status = await Permission.microphone.request();

    if (status.isDeniedOrPermanentlyDenied) {
      if (!context.mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => const MicrophonePermissionSheet(),
      );
      status = await Permission.microphone.status;
    }

    if (status.isDeniedOrPermanentlyDenied) return;

    if (!context.mounted) return;

    context.read<RecordingsCubit>().startRecording();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () {
                _onPressRecord(context);
              },
              icon: const Icon(Icons.mic_rounded, size: 20),
              label: Text(t.startRecording),
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
                Helper.hapticFeedback();
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
