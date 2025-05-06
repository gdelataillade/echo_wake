import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'dart:async';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();
  final _playerStateController = StreamController<Recording?>.broadcast();

  Stream<Recording?> get onPlayerStateChanged => _playerStateController.stream;
  Recording? get currentlyPlayingRecording => _currentRecording;

  Recording? _currentRecording;

  AudioPlayerService() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        _currentRecording = null;
        _playerStateController.add(null);
      } else if (state == PlayerState.playing) {
        _playerStateController.add(_currentRecording);
      } else if (state == PlayerState.paused) {
        _playerStateController.add(_currentRecording);
      } else if (state == PlayerState.stopped) {
        _currentRecording = null;
        _playerStateController.add(null);
      }
    });
  }

  Future<void> playRecording(Recording recording) async {
    await _audioPlayer.stop();
    final fullPath = await recording.getFullPath();
    _currentRecording = recording;
    _audioPlayer.play(DeviceFileSource(fullPath));
    _playerStateController.add(recording);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentRecording = null;
    _playerStateController.add(null);
  }

  Future<Duration> getDuration(File file) async {
    final source = DeviceFileSource(file.path);
    _audioPlayer.setSource(source);
    final duration = await _audioPlayer.getDuration();
    return duration ?? Duration.zero;
  }

  void dispose() {
    _audioPlayer.dispose();
    _playerStateController.close();
  }
}
