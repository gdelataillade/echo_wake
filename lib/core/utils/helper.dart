import 'package:echo_wake/domain/services/storage.dart';
import 'package:flutter/services.dart';

class Helper {
  static const String hapticKey = 'settingsHapticFeedback';
  static bool hapticEnabled = true;

  static Future<void> init() async {
    final storage = await StorageService.getInstance();
    hapticEnabled = storage.getBool(hapticKey) ?? true;
  }

  static void hapticFeedback() async {
    if (hapticEnabled) {
      HapticFeedback.lightImpact();
    }
  }
}
