part of 'alarm_bloc.dart';

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlarms extends AlarmEvent {}

class CreateAlarm extends AlarmEvent {
  final DateTime dateTime;
  final bool loopAudio;
  final double? volume;
  final String recordingPath;
  final String recordingName;

  const CreateAlarm({
    required this.dateTime,
    required this.recordingPath,
    required this.recordingName,
    this.loopAudio = false,
    this.volume,
  });

  @override
  List<Object?> get props => [dateTime, recordingPath, recordingName];
}

class StopAlarm extends AlarmEvent {
  final int id;

  const StopAlarm(this.id);

  @override
  List<Object?> get props => [id];
}
