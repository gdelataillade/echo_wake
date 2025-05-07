import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RenameRecordingDialog extends StatelessWidget {
  final Recording recording;
  final List<Recording> recordings;

  const RenameRecordingDialog({
    super.key,
    required this.recording,
    required this.recordings,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: recording.name);

    return AlertDialog(
      title: Text(t.renameRecording),
      content: TextField(
        autofocus: true,
        controller: nameController,
        decoration: InputDecoration(
          labelText: t.newName,
          suffix: GestureDetector(
            onTap: () => nameController.clear(),
            child: const Icon(Icons.clear, size: 22),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.cancel),
        ),
        TextButton(
          onPressed: () async {
            Helper.hapticFeedback();

            final newName = nameController.text.trim();

            if (newName.isEmpty) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.recordingNameCannotBeEmpty),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return;
            }

            final isDuplicate = recordings.any(
              (r) => r.id != recording.id && r.name == newName,
            );

            if (isDuplicate) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.aRecordingWithThisNameAlreadyExists),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return;
            }

            final index = recordings.indexWhere((r) => r.id == recording.id);
            if (index != -1) {
              final bloc = context.read<RecordingsCubit>();
              bloc.updateRecordingName(recording, newName);
            }
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: Text(t.save),
        ),
      ],
    );
  }
}
