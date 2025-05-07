import 'package:echo_wake/domain/services/storage.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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

  static Future<bool> requestNotificationPermission() async {
    final permission = await Permission.notification.request();
    return permission.isGranted;
  }
}

extension PermissionStatusX on PermissionStatus {
  bool get isDeniedOrPermanentlyDenied =>
      this == PermissionStatus.denied ||
      this == PermissionStatus.permanentlyDenied;
}
