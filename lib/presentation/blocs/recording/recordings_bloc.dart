import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
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
      final path =
          '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';

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
    }
  }

  Future<void> stopRecording({bool cancel = false}) async {
    try {
      _durationTimer?.cancel();
      final path = await _recorder.stop();
      if (path != null && !cancel) {
        // If not canceling, save the recording
        saveRecording(
          Recording(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: DateTime.now().toString().split('.')[0],
            filename: path.split('Documents/').last,
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
          state.recordings
              .where((recording) => recording.id != recording.id)
              .toList();

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

  void updateRecordingName(String name) {
    // Since we don't have a recordingName field in the state,
    // we should update the recording's name in the list
    final updatedRecordings =
        state.recordings.map((recording) {
          if (recording.id == state.recordings.first.id) {
            return recording.copyWith(name: name);
          }
          return recording;
        }).toList();
    emit(state.copyWith(recordings: updatedRecordings));
  }
}
