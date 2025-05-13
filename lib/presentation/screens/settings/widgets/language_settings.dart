import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

const List<LanguageOption> languages = [
  LanguageOption('en', 'English', 'GB'),
  LanguageOption('fr', 'Français', 'FR'),
  LanguageOption('es', 'Español', 'ES'),
  LanguageOption('de', 'Deutsch', 'DE'),
  LanguageOption('it', 'Italiano', 'IT'),
  LanguageOption('pt', 'Português', 'PT'),
];

class LanguageSettings extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSettings({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 12,
      children:
          languages.map((lang) {
            final selected = lang.code == selectedLanguage;
            return GestureDetector(
              onTap: () => onLanguageChanged(lang.code),
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: selected ? colorScheme.primary : Colors.transparent,
                  ),
                ),
                child: CountryFlag.fromCountryCode(
                  lang.flagCode,
                  shape: const RoundedRectangle(20),
                  height: 40,
                  width: 40,
                ),
              ),
            );
          }).toList(),
    );
  }
}

class LanguageOption {
  final String code;
  final String label;
  final String flagCode;
  const LanguageOption(this.code, this.label, this.flagCode);
}
