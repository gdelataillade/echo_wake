import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/services/storage.dart';
import '../../../gen/strings.g.dart';
import 'widgets/language_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const String languageKey = 'settingsLanguage';
  static const String hapticKey = 'settingsHapticFeedback';

  late StorageService _storage;
  String _selectedLanguage = 'en';
  bool _hapticEnabled = true;
  bool _loading = true;

  final List<LanguageOption> _languages = [
    LanguageOption('de', 'Deutsch', 'DE'),
    LanguageOption('en', 'English', 'GB'),
    LanguageOption('es', 'Español', 'ES'),
    LanguageOption('fr', 'Français', 'FR'),
    LanguageOption('it', 'Italiano', 'IT'),
    LanguageOption('pt', 'Português', 'PT'),
  ];

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  Future<void> _initSettings() async {
    _storage = await StorageService.getInstance();
    setState(() {
      _selectedLanguage = _storage.getString(languageKey) ?? 'en';
      _hapticEnabled = _storage.getBool(hapticKey) ?? true;
      _loading = false;
    });
  }

  Future<void> _onLanguageChanged(String? code) async {
    if (code == null) return;
    setState(() {
      _selectedLanguage = code;
    });
    await _storage.setString(languageKey, code);
    await LocaleSettings.setLocaleRaw(code);
  }

  Future<void> _onHapticChanged(bool value) async {
    setState(() {
      _hapticEnabled = value;
    });
    await _storage.setBool(hapticKey, value);
    Helper.hapticEnabled = value;
    Helper.hapticFeedback();
  }

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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(context.t.settings)),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(context.t.language, style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    LanguageSettings(
                      selectedLanguage: _selectedLanguage,
                      languages: _languages,
                      onLanguageChanged: _onLanguageChanged,
                    ),
                    const SizedBox(height: 24),
                    SwitchListTile.adaptive(
                      value: _hapticEnabled,
                      onChanged: _onHapticChanged,
                      title: Text(context.t.hapticFeedback),
                      subtitle: Text(context.t.hapticFeedbackDescription),
                      secondary: const Icon(Icons.vibration),
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                      title: Text('Manage app permissions'),
                      subtitle: Text('Notification and microphone'),
                      trailing: const Icon(Icons.app_settings_alt),
                      onTap: () => openAppSettings(),
                    ),
                    const SizedBox(height: 32),
                    Text(context.t.privacy, style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.t.privacyDescription,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _launchEmail,
                      icon: const Icon(Icons.bug_report_outlined),
                      label: Text(context.t.reportBugOrFeature),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                    ),
                    const Spacer(),
                    const SettingsFooter(),
                  ],
                ),
              ),
    );
  }
}
