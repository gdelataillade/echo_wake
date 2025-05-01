import 'package:alarm/model/volume_settings.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alarm/alarm.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmInitial()) {
    loadAlarms();

    // Listen to alarm updates
    Alarm.scheduled.listen((_) => loadAlarms());
    Alarm.ringing.listen((_) => loadAlarms());
  }

  Future<void> loadAlarms() async {
    try {
      emit(AlarmLoading());
      final alarms = await Alarm.getAlarms();
      emit(AlarmLoaded(alarms));
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }

  Future<void> createAlarm({
    required DateTime dateTime,
    required String recordingPath,
    required String recordingName,
    bool loopAudio = false,
    double? volume,
  }) async {
    try {
      emit(AlarmLoading());

      // Check if file exists
      final appDir = await getApplicationDocumentsDirectory();
      final fullPath = '${appDir.path}/$recordingPath';
      final file = File(fullPath);
      if (!await file.exists()) {
        debugPrint('Error: Audio file does not exist at path: $fullPath');
        emit(AlarmError('Audio file not found'));
        return;
      }
      debugPrint('Audio file exists at path: $fullPath');

      final alarmSettings = AlarmSettings(
        id: DateTime.now().millisecondsSinceEpoch ~/ 100000,
        dateTime: dateTime,
        assetAudioPath: recordingPath.split('Documents/').last,
        loopAudio: loopAudio,
        vibrate: false,
        notificationSettings: NotificationSettings(
          title: 'Echo Wake',
          body: '🎙️ $recordingName',
          stopButton: 'Stop',
        ),
        volumeSettings: VolumeSettings.fixed(volume: volume),
      );

      debugPrint('Setting alarm with settings: ${alarmSettings.toJson()}');
      await Alarm.set(alarmSettings: alarmSettings);
      debugPrint('Alarm set successfully');
      loadAlarms();
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }

  Future<void> stopAlarm(int id) async {
    try {
      emit(AlarmLoading());
      await Alarm.stop(id);
      loadAlarms();
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }
}
