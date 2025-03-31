import 'package:echo_wake/data/models/recording.dart';
import 'package:equatable/equatable.dart';

enum RecordingStatus { initial, recording, stopped, error }

class RecordingsState extends Equatable {
  final List<Recording> recordings;
  final RecordingStatus status;
  final String? errorMessage;
  final Duration recordingDuration;

  const RecordingsState({
    this.recordings = const [],
    this.status = RecordingStatus.initial,
    this.errorMessage,
    this.recordingDuration = Duration.zero,
  });

  RecordingsState copyWith({
    List<Recording>? recordings,
    RecordingStatus? status,
    String? errorMessage,
    Duration? recordingDuration,
  }) {
    return RecordingsState(
      recordings: recordings ?? this.recordings,
      status: status ?? this.status,
      errorMessage: errorMessage,
      recordingDuration: recordingDuration ?? this.recordingDuration,
    );
  }

  @override
  List<Object?> get props => [
    recordings,
    status,
    errorMessage,
    recordingDuration,
  ];
}
