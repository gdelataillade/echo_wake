import 'package:echo_wake/presentation/screens/settings/widgets/app_settings.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/footer.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/privacy.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/report.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/snooze_picker.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import '../../../domain/services/storage.dart';
import '../../../gen/strings.g.dart';
import 'widgets/language_settings.dart';
import 'widgets/haptic_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const String languageKey = 'settingsLanguage';

  late StorageService _storage;
  String _selectedLanguage = 'en';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  Future<void> _initSettings() async {
    _storage = await StorageService.getInstance();
    setState(() {
      _selectedLanguage = _storage.getString(languageKey) ?? 'en';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.settings)),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      LanguageSettings(
                        selectedLanguage: _selectedLanguage,
                        onLanguageChanged: _onLanguageChanged,
                      ),
                      const SizedBox(height: 8),
                      const HapticSwitch(),
                      const SettingsSnoozePicker(),
                      const SettingsThemeSwitch(),
                      const SettingsAppSettings(),
                      const SettingsPrivacySection(),
                      const SettingsReportButton(),
                      const SettingsFooter(),
                    ],
                  ),
                ),
              ),
    );
  }
}
