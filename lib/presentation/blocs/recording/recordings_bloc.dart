import 'package:echo_wake/data/models/recording.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_event.dart';
import 'package:echo_wake/presentation/blocs/recording/recordings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class RecordingsBloc extends Bloc<RecordingsEvent, RecordingsState> {
  final StorageService _storage;
  final AudioRecorder _recorder;

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
    await _recorder.stop();
  }

  Future<void> _onSaveRecording(
    SaveRecording event,
    Emitter<RecordingsState> emit,
  ) async {}

  Future<void> _onDeleteRecording(
    DeleteRecording event,
    Emitter<RecordingsState> emit,
  ) async {}

  Future<void> _onUpdateRecordingName(
    UpdateRecordingName event,
    Emitter<RecordingsState> emit,
  ) async {}

  Future<void> _onUpdateRecordingDuration(
    UpdateRecordingDuration event,
    Emitter<RecordingsState> emit,
  ) async {}
}
