import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:flutter/material.dart';

class AudioPlayerButton extends StatefulWidget {
  final Recording recording;
  final AudioPlayerService audioPlayerService;
  final VoidCallback? onPlaybackStateChanged;

  const AudioPlayerButton({
    super.key,
    required this.recording,
    required this.audioPlayerService,
    this.onPlaybackStateChanged,
  });

  @override
  State<AudioPlayerButton> createState() => _AudioPlayerButtonState();
}

class _AudioPlayerButtonState extends State<AudioPlayerButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Recording?>(
      stream: widget.audioPlayerService.onPlayerStateChanged,
      builder: (context, snapshot) {
        final isPlaying = snapshot.data == widget.recording;

        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.5),
          ),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.stop : Icons.play_arrow,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              if (isPlaying) {
                await widget.audioPlayerService.stop();
              } else {
                await widget.audioPlayerService.playRecording(widget.recording);
              }
              widget.onPlaybackStateChanged?.call();
            },
          ),
        );
      },
    );
  }
}
