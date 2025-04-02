import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_event.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class RecordingsBloc extends Bloc<RecordingsEvent, RecordingsState> {
  final StorageService _storage;
  final AudioRecorder _recorder;
  Timer? _durationTimer;

  RecordingsBloc({required StorageService storage, AudioRecorder? recorder})
    : _storage = storage,
      _recorder = recorder ?? AudioRecorder(),
      super(const RecordingsState()) {
    on<LoadRecordings>(_onLoadRecordings);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<SaveRecording>(_onSaveRecording);
    on<DeleteRecording>(_onDeleteRecording);
    on<UpdateRecordingName>(_onUpdateRecordingName);
    on<UpdateRecordingDuration>(_onUpdateRecordingDuration);
  }

  @override
  Future<void> close() {
    _durationTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadRecordings(
    LoadRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    final recordingsJson = _storage.getStringList('recordings') ?? [];
    final recordings =
        recordingsJson
            .map((json) => Recording.fromJson(jsonDecode(json)))
            .toList();
    emit(state.copyWith(recordings: recordings));
  }

  Future<void> _onStartRecording(
    StartRecording event,
    Emitter<RecordingsState> emit,
  ) async {
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
        add(
          UpdateRecordingDuration(
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

  Future<void> _onStopRecording(
    StopRecording event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      _durationTimer?.cancel();
      final path = await _recorder.stop();
      if (path != null && !event.cancel) {
        // If not canceling, save the recording
        add(
          SaveRecording(
            Recording(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: DateTime.now().toString().split('.')[0],
              path: path,
              duration: state.recordingDuration,
            ),
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

  Future<void> _onSaveRecording(
    SaveRecording event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      final newRecording = Recording(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.recording.name,
        path: event.recording.path,
        duration: event.recording.duration,
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

  Future<void> _onDeleteRecording(
    DeleteRecording event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      final updatedRecordings =
          state.recordings
              .where((recording) => recording.id != event.recording.id)
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

  Future<void> _onUpdateRecordingName(
    UpdateRecordingName event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      final updatedRecordings =
          state.recordings.map((recording) {
            if (recording.id == event.recording.id) {
              return recording.copyWith(name: event.newName);
            }
            return recording;
          }).toList();

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
          errorMessage: 'Failed to update recording name: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onUpdateRecordingDuration(
    UpdateRecordingDuration event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      emit(state.copyWith(recordingDuration: event.duration));
    } catch (e) {
      emit(
        state.copyWith(
          status: RecordingStatus.error,
          errorMessage: 'Failed to update recording duration: ${e.toString()}',
        ),
      );
    }
  }
}
