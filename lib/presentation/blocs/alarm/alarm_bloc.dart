import 'package:alarm/model/volume_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alarm/alarm.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial()) {
    on<LoadAlarms>(_onLoadAlarms);
    on<CreateAlarm>(_onCreateAlarm);
    on<DeleteAlarm>(_onDeleteAlarm);
    on<StopAlarm>(_onStopAlarm);

    // Listen to alarm updates
    Alarm.scheduled.listen((_) => add(LoadAlarms()));
    Alarm.ringing.listen((_) => add(LoadAlarms()));
  }

  Future<void> _onLoadAlarms(LoadAlarms event, Emitter<AlarmState> emit) async {
    try {
      emit(AlarmLoading());
      final alarms = await Alarm.getAlarms();
      emit(AlarmLoaded(alarms));
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }

  Future<void> _onCreateAlarm(
    CreateAlarm event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      emit(AlarmLoading());

      final alarmSettings = AlarmSettings(
        id: DateTime.now().millisecondsSinceEpoch ~/ 100000,
        dateTime: event.dateTime,
        assetAudioPath: 'assets/marimba.mp3',
        loopAudio: false,
        vibrate: false,
        notificationSettings: NotificationSettings(
          title: 'Echo Wake',
          body: 'Your alarm is playing !',
        ),
        volumeSettings: VolumeSettings.fixed(volume: 0.8),
      );

      await Alarm.set(alarmSettings: alarmSettings);
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }

  Future<void> _onDeleteAlarm(
    DeleteAlarm event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      emit(AlarmLoading());
      await Alarm.stop(event.id);
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }

  Future<void> _onStopAlarm(StopAlarm event, Emitter<AlarmState> emit) async {
    try {
      emit(AlarmLoading());
      await Alarm.stop(event.id);
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }
}
