import 'package:echo_wake/data/models/recording.dart';
import 'package:flutter/material.dart';

class RecordingItem extends StatelessWidget {
  final Recording recording;
  final bool isPlaying;
  final Function(Recording) onTogglePlayback;
  final Function(Recording) onSelect;
  final bool selectionMode;
  const RecordingItem({
    super.key,
    required this.recording,
    required this.isPlaying,
    required this.onTogglePlayback,
    required this.onSelect,
    this.selectionMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: GestureDetector(
          onTap: () => onSelect(recording),
          child: Text(
            recording.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        subtitle: GestureDetector(
          onTap: () => onSelect(recording),
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
            onPressed: () => onTogglePlayback(recording),
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
                onPressed: () => onTogglePlayback(recording),
              ),
            ),

            if (selectionMode) ...[
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
        onTap: () {
          if (selectionMode) {
            Navigator.pop(context, recording);
          }
        },
      ),
    );
  }
}
