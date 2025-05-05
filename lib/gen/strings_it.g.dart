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
class TranslationsIt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override String get alarms => 'Sveglie';
	@override String get recordings => 'Registrazioni';
	@override String get noAlarms => 'Nessuna sveglia impostata';
	@override String get tapPlusToAddAlarm => 'Tocca + per aggiungere una sveglia';
	@override String get alarmDeleted => 'Sveglia eliminata';
	@override String get addAlarm => 'Aggiungi sveglia';
	@override String get editAlarm => 'Modifica sveglia';
	@override String get stopAlarm => 'Ferma sveglia';
	@override String get error => 'Errore';
	@override String get setAlarmTime => 'Imposta ora sveglia';
	@override String get selectAlarmSound => 'Seleziona suoneria';
	@override String get playSoundRepeatedlyUntilAlarmStopped => 'Riproduci il suono ripetutamente fino all\'arresto della sveglia';
	@override String get customVolume => 'Volume personalizzato';
	@override String get setSpecificVolumeForThisAlarm => 'Imposta un volume specifico per questa sveglia';
	@override String get loopSound => 'Ripeti suono';
	@override String get saveChanges => 'Salva modifiche';
	@override String get cancel => 'Annulla';
	@override String get setAlarm => 'Imposta sveglia';
	@override String get recordASound => 'Registra un suono';
	@override String get noRecordingsYet => 'Nessuna registrazione';
	@override String get settings => 'Impostazioni';
	@override String get language => 'Lingua';
	@override String get reportBugOrFeature => 'Segnala un bug o chiedi una funzione';
	@override String get privacyDescription => 'Nessun dato viene raccolto. Tutto rimane sul tuo dispositivo. Nessun server. 100% offline.';
	@override String get builtWithLove => 'Costruito con ❤️ da Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Vibrazione leggera al tocco dei pulsanti';
	@override String get privacy => 'Privacy';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'alarms': return 'Sveglie';
			case 'recordings': return 'Registrazioni';
			case 'noAlarms': return 'Nessuna sveglia impostata';
			case 'tapPlusToAddAlarm': return 'Tocca + per aggiungere una sveglia';
			case 'alarmDeleted': return 'Sveglia eliminata';
			case 'addAlarm': return 'Aggiungi sveglia';
			case 'editAlarm': return 'Modifica sveglia';
			case 'stopAlarm': return 'Ferma sveglia';
			case 'error': return 'Errore';
			case 'setAlarmTime': return 'Imposta ora sveglia';
			case 'selectAlarmSound': return 'Seleziona suoneria';
			case 'playSoundRepeatedlyUntilAlarmStopped': return 'Riproduci il suono ripetutamente fino all\'arresto della sveglia';
			case 'customVolume': return 'Volume personalizzato';
			case 'setSpecificVolumeForThisAlarm': return 'Imposta un volume specifico per questa sveglia';
			case 'loopSound': return 'Ripeti suono';
			case 'saveChanges': return 'Salva modifiche';
			case 'cancel': return 'Annulla';
			case 'setAlarm': return 'Imposta sveglia';
			case 'recordASound': return 'Registra un suono';
			case 'noRecordingsYet': return 'Nessuna registrazione';
			case 'settings': return 'Impostazioni';
			case 'language': return 'Lingua';
			case 'reportBugOrFeature': return 'Segnala un bug o chiedi una funzione';
			case 'privacyDescription': return 'Nessun dato viene raccolto. Tutto rimane sul tuo dispositivo. Nessun server. 100% offline.';
			case 'builtWithLove': return 'Costruito con ❤️ da Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Vibrazione leggera al tocco dei pulsanti';
			case 'privacy': return 'Privacy';
			default: return null;
		}
	}
}

