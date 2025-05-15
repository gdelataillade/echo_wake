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
	@override String get privacyDescription => 'Nessun dato viene raccolto. Tutto rimane sul tuo dispositivo.';
	@override String get builtWithLove => 'Costruito con ❤️ da Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Vibrazione leggera al tocco dei pulsanti';
	@override String get privacy => 'Privacy';
	@override late final _TranslationsOnboarding1It onboarding1 = _TranslationsOnboarding1It._(_root);
	@override late final _TranslationsOnboarding2It onboarding2 = _TranslationsOnboarding2It._(_root);
	@override late final _TranslationsOnboarding3It onboarding3 = _TranslationsOnboarding3It._(_root);
	@override String get skip => 'Salta';
	@override String get getStarted => 'Inizia';
	@override String get allowNotifications => 'Consenti notifiche';
	@override String get allowNotificationsDescription => 'Per assicurarti che la tua sveglia funzioni in modo affidabile, Echo Wake ha bisogno del tuo consenso per inviarti notifiche. È essenziale per assicurarti di non mancare la tua chiamata di sveglia!\n\nUtilizziamo solo le notifiche per informarti quando la tua sveglia suona. Nessun spam, promesso.';
	@override String get allow => 'Consenti';
	@override String get microphonePermission => 'Permesso microfono';
	@override String get microphonePermissionDescription => 'Per poter registrare audio, Echo Wake ha bisogno del tuo consenso per accedere al tuo microfono. Per favore, continua alle impostazioni per concedere il permesso.';
	@override String get ignore => 'Ignora';
	@override String get openSettings => 'Apri impostazioni';
	@override String get startRecording => 'Registra';
	@override String get voiceRecordings => 'Registrazioni';
	@override String get continueButton => 'Continua';
	@override String get manageAppPermissions => 'Gestisci permessi dell\'app';
	@override String get notificationAndMicrophone => 'Notifiche e microfono';
	@override String get renameRecording => 'Rinomina registrazione';
	@override String get newName => 'Nuovo nome';
	@override String get recordingNameCannotBeEmpty => 'Il nome della registrazione non può essere vuoto';
	@override String get aRecordingWithThisNameAlreadyExists => 'Una registrazione con questo nome esiste già';
	@override String get save => 'Salva';
	@override String get warningNotificationOnKillDescription => 'Le tue sveglie potrebbero non suonare se l\'app è chiusa. Toca qui per aprire l\'app.';
	@override String get theme => 'Tema';
	@override String get selectTheThemeForTheApp => 'Seleziona il tema per l\'app';
	@override String get system => 'Sistema';
	@override String get light => 'Chiaro';
	@override String get dark => 'Scuro';
	@override String get snooze => 'Snooze';
	@override String get snoozeDuration => 'Durata del snooze';
	@override String get snoozeDurationPicker => 'Seleziona la durata del snooze';
	@override String get snoozeDurationPickerDescription => 'Minuti prima che la sveglia suoni di nuovo';
	@override String get minutes => 'minuti';
	@override String get recordingDeleted => 'Registrazione eliminata';
	@override String get cannotDeleteRecordingLinkedToAlarm => 'Impossibile eliminare: questa registrazione è collegata a un allarme. Rimuovi prima l\'allarme.';
}

// Path: onboarding1
class _TranslationsOnboarding1It implements TranslationsOnboarding1En {
	_TranslationsOnboarding1It._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registra la tua carica del mattino';
	@override String get description => 'La tua voce, la tua energia, il tuo messaggio per svegliarti.';
}

// Path: onboarding2
class _TranslationsOnboarding2It implements TranslationsOnboarding2En {
	_TranslationsOnboarding2It._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Imposta la sveglia';
	@override String get description => 'E abbinala alla tua registrazione motivante.';
}

// Path: onboarding3
class _TranslationsOnboarding3It implements TranslationsOnboarding3En {
	_TranslationsOnboarding3It._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Svegliati';
	@override String get description => 'Inizia la giornata con le tue parole.';
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
			case 'privacyDescription': return 'Nessun dato viene raccolto. Tutto rimane sul tuo dispositivo.';
			case 'builtWithLove': return 'Costruito con ❤️ da Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Vibrazione leggera al tocco dei pulsanti';
			case 'privacy': return 'Privacy';
			case 'onboarding1.title': return 'Registra la tua carica del mattino';
			case 'onboarding1.description': return 'La tua voce, la tua energia, il tuo messaggio per svegliarti.';
			case 'onboarding2.title': return 'Imposta la sveglia';
			case 'onboarding2.description': return 'E abbinala alla tua registrazione motivante.';
			case 'onboarding3.title': return 'Svegliati';
			case 'onboarding3.description': return 'Inizia la giornata con le tue parole.';
			case 'skip': return 'Salta';
			case 'getStarted': return 'Inizia';
			case 'allowNotifications': return 'Consenti notifiche';
			case 'allowNotificationsDescription': return 'Per assicurarti che la tua sveglia funzioni in modo affidabile, Echo Wake ha bisogno del tuo consenso per inviarti notifiche. È essenziale per assicurarti di non mancare la tua chiamata di sveglia!\n\nUtilizziamo solo le notifiche per informarti quando la tua sveglia suona. Nessun spam, promesso.';
			case 'allow': return 'Consenti';
			case 'microphonePermission': return 'Permesso microfono';
			case 'microphonePermissionDescription': return 'Per poter registrare audio, Echo Wake ha bisogno del tuo consenso per accedere al tuo microfono. Per favore, continua alle impostazioni per concedere il permesso.';
			case 'ignore': return 'Ignora';
			case 'openSettings': return 'Apri impostazioni';
			case 'startRecording': return 'Registra';
			case 'voiceRecordings': return 'Registrazioni';
			case 'continueButton': return 'Continua';
			case 'manageAppPermissions': return 'Gestisci permessi dell\'app';
			case 'notificationAndMicrophone': return 'Notifiche e microfono';
			case 'renameRecording': return 'Rinomina registrazione';
			case 'newName': return 'Nuovo nome';
			case 'recordingNameCannotBeEmpty': return 'Il nome della registrazione non può essere vuoto';
			case 'aRecordingWithThisNameAlreadyExists': return 'Una registrazione con questo nome esiste già';
			case 'save': return 'Salva';
			case 'warningNotificationOnKillDescription': return 'Le tue sveglie potrebbero non suonare se l\'app è chiusa. Toca qui per aprire l\'app.';
			case 'theme': return 'Tema';
			case 'selectTheThemeForTheApp': return 'Seleziona il tema per l\'app';
			case 'system': return 'Sistema';
			case 'light': return 'Chiaro';
			case 'dark': return 'Scuro';
			case 'snooze': return 'Snooze';
			case 'snoozeDuration': return 'Durata del snooze';
			case 'snoozeDurationPicker': return 'Seleziona la durata del snooze';
			case 'snoozeDurationPickerDescription': return 'Minuti prima che la sveglia suoni di nuovo';
			case 'minutes': return 'minuti';
			case 'recordingDeleted': return 'Registrazione eliminata';
			case 'cannotDeleteRecordingLinkedToAlarm': return 'Impossibile eliminare: questa registrazione è collegata a un allarme. Rimuovi prima l\'allarme.';
			default: return null;
		}
	}
}

