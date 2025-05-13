import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';

class SettingsPrivacySection extends StatelessWidget {
  const SettingsPrivacySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.privacy_tip_outlined, size: 24),
      title: Text(context.t.privacy),
      subtitle: Text(context.t.privacyDescription),
    );
  }
}
