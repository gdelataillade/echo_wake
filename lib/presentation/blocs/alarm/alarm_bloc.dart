import 'package:alarm/model/volume_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alarm/alarm.dart';
import 'dart:io';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial()) {
    on<LoadAlarms>(_onLoadAlarms);
    on<CreateAlarm>(_onCreateAlarm);
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

      // Check if file exists
      final file = File(event.recordingPath);
      if (!await file.exists()) {
        debugPrint(
          'Error: Audio file does not exist at path: ${event.recordingPath}',
        );
        emit(AlarmError('Audio file not found'));
        return;
      }
      debugPrint('Audio file exists at path: ${event.recordingPath}');

      final alarmSettings = AlarmSettings(
        id: DateTime.now().millisecondsSinceEpoch ~/ 100000,
        dateTime: event.dateTime,
        assetAudioPath: event.recordingPath.split('Documents/').last,
        loopAudio: event.loopAudio,
        vibrate: false,
        notificationSettings: NotificationSettings(
          title: 'Echo Wake',
          body: '🎙️ ${event.recordingName}',
          stopButton: 'Stop',
        ),
        volumeSettings: VolumeSettings.fixed(volume: event.volume),
      );

      debugPrint('Setting alarm with settings: $alarmSettings');
      await Alarm.set(alarmSettings: alarmSettings);
      debugPrint('Alarm set successfully');
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
