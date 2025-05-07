import 'dart:io';

import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:echo_wake/services/audio_player_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class RecordingsCubit extends Cubit<RecordingsState> {
  final StorageService _storage;
  final AudioRecorder _recorder;
  Timer? _durationTimer;

  RecordingsCubit({required StorageService storage, AudioRecorder? recorder})
    : _storage = storage,
      _recorder = recorder ?? AudioRecorder(),
      super(const RecordingsState()) {
    loadRecordings();
  }

  @override
  Future<void> close() {
    _durationTimer?.cancel();
    return super.close();
  }

  Future<void> loadRecordings() async {
    final recordingsJson = _storage.getStringList('recordings') ?? [];
    final recordings =
        recordingsJson
            .map((json) => Recording.fromJson(jsonDecode(json)))
            .toList();
    emit(state.copyWith(recordings: recordings));
  }

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${dir.path}/recording_$timestamp.wav';

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 44100,
          numChannels: 1,
          bitRate: 128000,
        ),
        path: path,
      );

      _durationTimer?.cancel();
      _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        emit(
          state.copyWith(
            recordingDuration:
                state.recordingDuration + const Duration(seconds: 1),
          ),
        );
      });

      emit(
        state.copyWith(
          status: RecordingStatus.recording,
          recordingDuration: Duration.zero,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RecordingStatus.error,
          errorMessage: 'Missing microphone permission',
        ),
      );
    }
  }

  Future<void> stopRecording({bool cancel = false}) async {
    try {
      _durationTimer?.cancel();
      final path = await _recorder.stop();
      if (path != null && !cancel) {
        // Extract timestamp from the path
        final timestamp = path.split('recording_').last.split('.wav').first;
        // If not canceling, save the recording
        saveRecording(
          Recording(
            id: timestamp,
            name: DateTime.now().toString().split('.')[0],
            filename: 'recording_$timestamp.wav',
            duration: state.recordingDuration,
          ),
        );
      }
      emit(
        state.copyWith(
          status: RecordingStatus.stopped,
          recordingDuration: Duration.zero,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecordingStatus.error,
          errorMessage: 'Failed to stop recording: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> saveRecording(Recording recording) async {
    try {
      final newRecording = Recording(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: recording.name,
        filename: recording.filename,
        duration: recording.duration,
      );

      final updatedRecordings = [...state.recordings, newRecording];

      // Save to persistent storage
      final recordingsJson =
          updatedRecordings
              .map((recording) => jsonEncode(recording.toJson()))
              .toList();
      await _storage.setStringList('recordings', recordingsJson);

      emit(
        state.copyWith(
          recordings: updatedRecordings,
          status: RecordingStatus.initial,
          recordingDuration: Duration.zero,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecordingStatus.error,
          errorMessage: 'Failed to save recording: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> deleteRecording(Recording recording) async {
    try {
      final updatedRecordings =
          state.recordings.where((r) => r.id != recording.id).toList();

      // Save to persistent storage
      final recordingsJson =
          updatedRecordings
              .map((recording) => jsonEncode(recording.toJson()))
              .toList();
      await _storage.setStringList('recordings', recordingsJson);

      emit(state.copyWith(recordings: updatedRecordings));
    } catch (e) {
      emit(
        state.copyWith(
          status: RecordingStatus.error,
          errorMessage: 'Failed to delete recording: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> updateRecordingName(Recording recording, String newName) async {
    final updatedRecordings =
        state.recordings.map((r) {
          if (r.id == recording.id) {
            return r.copyWith(name: newName);
          }
          return r;
        }).toList();

    final recordingsJson =
        updatedRecordings.map((r) => jsonEncode(r.toJson())).toList();
    await _storage.setStringList('recordings', recordingsJson);

    emit(state.copyWith(recordings: updatedRecordings));
  }

  Future<void> importAudioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav', 'mp3', 'm4a', 'aac', 'ogg'],
    );
    if (result != null) {
      final sourceFile = File(result.files.first.path!);
      final duration = await AudioPlayerService().getDuration(sourceFile);

      // Get app's documents directory and create a unique filename
      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = sourceFile.path.split('.').last;
      final newFilename = 'recording_$timestamp.$extension';
      final newPath = '${dir.path}/$newFilename';

      // Copy the file to app's local storage
      await sourceFile.copy(newPath);

      final recording = Recording(
        id: timestamp.toString(),
        name: sourceFile.path.split('/').last.split('.').first,
        filename: newFilename,
        duration: duration,
      );
      await saveRecording(recording);
    }
  }

  Future<Recording> getRecordingById(String id) async {
    final recordings = state.recordings;
    return recordings.firstWhere((recording) => recording.id == id);
  }
}
