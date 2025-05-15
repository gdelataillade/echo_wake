import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:echo_wake/domain/services/storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String themeKey = 'settingsThemeMode';
  final StorageService _storage;

  ThemeCubit({required StorageService storage})
    : _storage = storage,
      super(ThemeMode.system) {
    _init();
  }

  Future<void> _init() async {
    final themeString = _storage.getString(themeKey);
    if (themeString != null) {
      switch (themeString) {
        case 'light':
          emit(ThemeMode.light);
          break;
        case 'dark':
          emit(ThemeMode.dark);
          break;
        case 'system':
        default:
          emit(ThemeMode.system);
      }
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    await _storage.setString(themeKey, _themeModeToString(mode));
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
