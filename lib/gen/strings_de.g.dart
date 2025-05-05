///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override String get alarms => 'Wecker';
	@override String get recordings => 'Aufnahmen';
	@override String get noAlarms => 'Keine Wecker eingestellt';
	@override String get tapPlusToAddAlarm => 'Tippen Sie auf +, um einen Wecker hinzuzufügen';
	@override String get alarmDeleted => 'Wecker gelöscht';
	@override String get addAlarm => 'Wecker hinzufügen';
	@override String get editAlarm => 'Wecker bearbeiten';
	@override String get stopAlarm => 'Wecker stoppen';
	@override String get error => 'Fehler';
	@override String get setAlarmTime => 'Weckzeit einstellen';
	@override String get selectAlarmSound => 'Weckton auswählen';
	@override String get playSoundRepeatedlyUntilAlarmStopped => 'Ton wiederholt abspielen, bis der Wecker gestoppt wird';
	@override String get customVolume => 'Individuelle Lautstärke';
	@override String get setSpecificVolumeForThisAlarm => 'Spezifische Lautstärke für diesen Wecker einstellen';
	@override String get loopSound => 'Ton wiederholen';
	@override String get saveChanges => 'Änderungen speichern';
	@override String get cancel => 'Abbrechen';
	@override String get setAlarm => 'Wecker einstellen';
	@override String get recordASound => 'Ton aufnehmen';
	@override String get noRecordingsYet => 'Noch keine Aufnahmen';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'alarms': return 'Wecker';
			case 'recordings': return 'Aufnahmen';
			case 'noAlarms': return 'Keine Wecker eingestellt';
			case 'tapPlusToAddAlarm': return 'Tippen Sie auf +, um einen Wecker hinzuzufügen';
			case 'alarmDeleted': return 'Wecker gelöscht';
			case 'addAlarm': return 'Wecker hinzufügen';
			case 'editAlarm': return 'Wecker bearbeiten';
			case 'stopAlarm': return 'Wecker stoppen';
			case 'error': return 'Fehler';
			case 'setAlarmTime': return 'Weckzeit einstellen';
			case 'selectAlarmSound': return 'Weckton auswählen';
			case 'playSoundRepeatedlyUntilAlarmStopped': return 'Ton wiederholt abspielen, bis der Wecker gestoppt wird';
			case 'customVolume': return 'Individuelle Lautstärke';
			case 'setSpecificVolumeForThisAlarm': return 'Spezifische Lautstärke für diesen Wecker einstellen';
			case 'loopSound': return 'Ton wiederholen';
			case 'saveChanges': return 'Änderungen speichern';
			case 'cancel': return 'Abbrechen';
			case 'setAlarm': return 'Wecker einstellen';
			case 'recordASound': return 'Ton aufnehmen';
			case 'noRecordingsYet': return 'Noch keine Aufnahmen';
			default: return null;
		}
	}
}

