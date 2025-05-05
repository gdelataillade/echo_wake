import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../../../../gen/strings.g.dart';

class LanguageSettings extends StatelessWidget {
  final String selectedLanguage;
  final List<LanguageOption> languages;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSettings({
    super.key,
    required this.selectedLanguage,
    required this.languages,
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
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CountryFlag.fromCountryCode(
                    lang.flagCode,
                    shape: const RoundedRectangle(3),
                    height: 20,
                    width: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(lang.label),
                ],
              ),
              selected: selected,
              onSelected: (v) => onLanguageChanged(lang.code),
              selectedColor: colorScheme.primary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: selected ? colorScheme.primary : colorScheme.onSurface,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
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
