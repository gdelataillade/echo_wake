import 'package:alarm/model/volume_settings.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/gen/strings.g.dart';
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

    Alarm.setWarningNotificationOnKill(
      'Echo Wake',
      t.warningNotificationOnKillDescription,
    );
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
    required String recordingId,
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

      final now = DateTime.now();
      final dt =
          dateTime.isBefore(now) ? dateTime.add(Duration(days: 1)) : dateTime;

      final alarmSettings = AlarmSettings(
        id: now.millisecondsSinceEpoch ~/ 1000,
        dateTime: dt,
        assetAudioPath: recordingPath.split('Documents/').last,
        loopAudio: loopAudio,
        vibrate: false,
        warningNotificationOnKill: Platform.isIOS,
        notificationSettings: NotificationSettings(
          title: 'Echo Wake',
          body: '🎙️ $recordingName',
          stopButton: 'Stop',
        ),
        volumeSettings: VolumeSettings.fixed(volume: volume),
        payload: recordingId,
      );

      debugPrint('Setting alarm with settings: ${alarmSettings.toJson()}');
      await Alarm.set(alarmSettings: alarmSettings);
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

  Future<void> snoozeAlarm(int id) async {
    try {
      emit(AlarmLoading());
      final alarm = await Alarm.getAlarm(id);
      if (alarm == null) {
        emit(AlarmError('Alarm not found'));
        return;
      }

      final storage = await StorageService.getInstance();
      final snoozeDuration = storage.getInt('settingsSnoozeDuration') ?? 10;

      await Alarm.set(
        alarmSettings: alarm.copyWith(
          dateTime: DateTime.now().add(Duration(minutes: snoozeDuration)),
        ),
      );

      loadAlarms();
    } catch (e) {
      emit(AlarmError(e.toString()));
    }
  }

  Future<List<AlarmSettings>> getAlarms() async {
    final alarms = await Alarm.getAlarms();
    return alarms;
  }
}
