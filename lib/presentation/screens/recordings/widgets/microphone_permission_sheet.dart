import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MicrophonePermissionSheet extends StatelessWidget {
  const MicrophonePermissionSheet({super.key});

  Future<void> _handleAccept(BuildContext context) async {
    await openAppSettings();
    if (!context.mounted) return;
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.mic_rounded, size: 56, color: colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              t.microphonePermission,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              t.microphonePermissionDescription,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(t.ignore),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.app_settings_alt),
                    label: Text(t.openSettings, textAlign: TextAlign.center),
                    onPressed: () => _handleAccept(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
