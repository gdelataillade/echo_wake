part of 'alarm_bloc.dart';

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlarms extends AlarmEvent {}

class CreateAlarm extends AlarmEvent {
  final DateTime dateTime;

  const CreateAlarm({required this.dateTime});

  @override
  List<Object?> get props => [dateTime];
}

class DeleteAlarm extends AlarmEvent {
  final int id;

  const DeleteAlarm(this.id);

  @override
  List<Object?> get props => [id];
}

class StopAlarm extends AlarmEvent {
  final int id;

  const StopAlarm(this.id);

  @override
  List<Object?> get props => [id];
}
