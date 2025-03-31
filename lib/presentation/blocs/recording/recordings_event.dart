import 'package:echo_wake/data/models/recording.dart';
import 'package:equatable/equatable.dart';

abstract class RecordingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRecordings extends RecordingsEvent {}

class StartRecording extends RecordingsEvent {}

class StopRecording extends RecordingsEvent {
  final bool cancel;

  StopRecording({this.cancel = false});

  @override
  List<Object?> get props => [cancel];
}

class SaveRecording extends RecordingsEvent {
  final Recording recording;

  SaveRecording(this.recording);

  @override
  List<Object?> get props => [recording];
}

class DeleteRecording extends RecordingsEvent {
  final Recording recording;

  DeleteRecording(this.recording);

  @override
  List<Object?> get props => [recording];
}

class UpdateRecordingName extends RecordingsEvent {
  final Recording recording;
  final String newName;

  UpdateRecordingName(this.recording, this.newName);

  @override
  List<Object?> get props => [recording, newName];
}

class UpdateRecordingDuration extends RecordingsEvent {
  final Duration duration;

  UpdateRecordingDuration(this.duration);

  @override
  List<Object?> get props => [duration];
}
