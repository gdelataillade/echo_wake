import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Text.rich(
          TextSpan(
            text: 'Built with 💙 with Flutter, by ',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: InkWell(
                  onTap:
                      () => launchUrl(
                        Uri.parse('https://www.gdelataillade.me'),
                        mode: LaunchMode.externalApplication,
                      ),
                  child: Text(
                    'Gautier de Lataillade',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
