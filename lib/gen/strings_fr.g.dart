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
class TranslationsFr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override String get alarms => 'Réveils';
	@override String get recordings => 'Enregistrements';
	@override String get noAlarms => 'Aucun réveil configuré';
	@override String get tapPlusToAddAlarm => 'Appuyez sur + pour ajouter un réveil';
	@override String get alarmDeleted => 'Réveil supprimé';
	@override String get addAlarm => 'Ajouter un réveil';
	@override String get editAlarm => 'Modifier le réveil';
	@override String get stopAlarm => 'Arrêter le réveil';
	@override String get error => 'Erreur';
	@override String get setAlarmTime => 'Définir l\'heure du réveil';
	@override String get selectAlarmSound => 'Sélectionner la sonnerie';
	@override String get playSoundRepeatedlyUntilAlarmStopped => 'Jouer la sonnerie en boucle jusqu\'à l\'arrêt du réveil';
	@override String get customVolume => 'Volume personnalisé';
	@override String get setSpecificVolumeForThisAlarm => 'Définir un volume spécifique pour ce réveil';
	@override String get loopSound => 'Sonnerie en boucle';
	@override String get saveChanges => 'Enregistrer les modifications';
	@override String get cancel => 'Annuler';
	@override String get setAlarm => 'Définir le réveil';
	@override String get recordASound => 'Enregistrer une sonnerie';
	@override String get noRecordingsYet => 'Aucun enregistrement';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'alarms': return 'Réveils';
			case 'recordings': return 'Enregistrements';
			case 'noAlarms': return 'Aucun réveil configuré';
			case 'tapPlusToAddAlarm': return 'Appuyez sur + pour ajouter un réveil';
			case 'alarmDeleted': return 'Réveil supprimé';
			case 'addAlarm': return 'Ajouter un réveil';
			case 'editAlarm': return 'Modifier le réveil';
			case 'stopAlarm': return 'Arrêter le réveil';
			case 'error': return 'Erreur';
			case 'setAlarmTime': return 'Définir l\'heure du réveil';
			case 'selectAlarmSound': return 'Sélectionner la sonnerie';
			case 'playSoundRepeatedlyUntilAlarmStopped': return 'Jouer la sonnerie en boucle jusqu\'à l\'arrêt du réveil';
			case 'customVolume': return 'Volume personnalisé';
			case 'setSpecificVolumeForThisAlarm': return 'Définir un volume spécifique pour ce réveil';
			case 'loopSound': return 'Sonnerie en boucle';
			case 'saveChanges': return 'Enregistrer les modifications';
			case 'cancel': return 'Annuler';
			case 'setAlarm': return 'Définir le réveil';
			case 'recordASound': return 'Enregistrer une sonnerie';
			case 'noRecordingsYet': return 'Aucun enregistrement';
			default: return null;
		}
	}
}

