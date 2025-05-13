import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsAppSettings extends StatefulWidget {
  const SettingsAppSettings({super.key});

  @override
  State<SettingsAppSettings> createState() => _SettingsAppSettingsState();
}

class _SettingsAppSettingsState extends State<SettingsAppSettings> {
  bool _microphonePermissionGranted = false;
  bool _notificationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final microphonePermission = await Permission.microphone.status;
    final notificationPermission = await Permission.notification.status;
    setState(() {
      _microphonePermissionGranted = microphonePermission.isGranted;
      _notificationPermissionGranted = notificationPermission.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.app_settings_alt),
      title: Text(context.t.manageAppPermissions),
      subtitle: Text(context.t.notificationAndMicrophone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _microphonePermissionGranted ? Icons.mic : Icons.mic_off,
            size: 20,
          ),
          const SizedBox(width: 2),
          Icon(
            _notificationPermissionGranted
                ? Icons.notifications
                : Icons.notifications_off,
            size: 20,
          ),
        ],
      ),
      onTap: () => openAppSettings(),
    );
  }
}
