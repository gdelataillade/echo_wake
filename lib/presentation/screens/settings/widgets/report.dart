import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsReportButton extends StatelessWidget {
  const SettingsReportButton({super.key});

  Future<void> _launchEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'gautier2406@gmail.com',
      query: 'subject=Echo Wake Feedback',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ElevatedButton.icon(
        onPressed: _launchEmail,
        icon: const Icon(Icons.bug_report_outlined),
        label: Text(context.t.reportBugOrFeature, textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          fixedSize: const Size(double.infinity, 48),
        ),
      ),
    );
  }
}
