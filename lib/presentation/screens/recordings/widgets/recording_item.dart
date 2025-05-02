import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/presentation/widgets/audio_player_button.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';

class RecordingItem extends StatefulWidget {
  final Recording recording;
  final AudioPlayerService audioPlayerService;
  final Function(Recording) onSelect;
  final bool selectionMode;
  final VoidCallback? onPlaybackStateChanged;

  const RecordingItem({
    super.key,
    required this.recording,
    required this.audioPlayerService,
    required this.onSelect,
    this.selectionMode = false,
    this.onPlaybackStateChanged,
  });

  @override
  State<RecordingItem> createState() => _RecordingItemState();
}

class _RecordingItemState extends State<RecordingItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: GestureDetector(
          onTap: () => widget.onSelect(widget.recording),
          child: Text(
            widget.recording.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        subtitle: GestureDetector(
          onTap: () => widget.onSelect(widget.recording),
          child: Text(
            '${widget.recording.duration.inMinutes}:${(widget.recording.duration.inSeconds % 60).toString().padLeft(2, '0')}',
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
            onPressed: () => widget.onSelect(widget.recording),
            icon: Icon(
              Icons.audio_file,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AudioPlayerButton(
              recording: widget.recording,
              audioPlayerService: widget.audioPlayerService,
              onPlaybackStateChanged: () => setState(() {}),
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
                  onPressed: () => Navigator.pop(context, widget.recording),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          if (widget.selectionMode) {
            Navigator.pop(context, widget.recording);
          }
        },
      ),
    );
  }
}
