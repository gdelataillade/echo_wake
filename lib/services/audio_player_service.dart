import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:echo_wake/data/models/recording.dart';
import 'dart:async';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _playerStateController = StreamController<void>.broadcast();
  Recording? _currentRecording;
  bool _isPlaying = false;

  Recording? get currentRecording => _currentRecording;
  bool get isPlaying => _isPlaying;
  Stream<void> get onPlayerStateChanged => _playerStateController.stream;

  AudioPlayerService() {
    _audioPlayer.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _playerStateController.add(null);
    });
  }

  Future<void> playRecording(Recording recording) async {
    if (_currentRecording?.id == recording.id) {
      if (_isPlaying) {
        await _audioPlayer.pause();
        await _audioPlayer.seek(Duration.zero);
        _isPlaying = false;
      } else {
        await _audioPlayer.resume();
        _isPlaying = true;
      }
    } else {
      await _audioPlayer.stop();
      final fullPath = await recording.getFullPath();
      await _audioPlayer.play(DeviceFileSource(fullPath));
      _currentRecording = recording;
      _isPlaying = true;
    }
    _playerStateController.add(null);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
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
