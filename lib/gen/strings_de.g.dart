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
	@override String get settings => 'Einstellungen';
	@override String get language => 'Sprache';
	@override String get reportBugOrFeature => 'Fehler melden oder Funktion anfragen';
	@override String get privacyDescription => 'Keine Daten werden gesammelt. Alles bleibt auf Ihrem Gerät.';
	@override String get builtWithLove => 'Mit ❤️ von Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Leichte Vibration beim Tippen auf Schaltflächen';
	@override String get privacy => 'Datenschutz';
	@override late final _TranslationsOnboarding1De onboarding1 = _TranslationsOnboarding1De._(_root);
	@override late final _TranslationsOnboarding2De onboarding2 = _TranslationsOnboarding2De._(_root);
	@override late final _TranslationsOnboarding3De onboarding3 = _TranslationsOnboarding3De._(_root);
	@override String get skip => 'Überspringen';
	@override String get getStarted => 'Los geht\'s';
	@override String get allowNotifications => 'Benachrichtigungen erlauben';
	@override String get allowNotificationsDescription => 'Um sicherzustellen, dass Ihr Wecker zuverlässig funktioniert, benötigt Echo Wake Ihre Erlaubnis, Ihnen Benachrichtigungen zu senden. Dies ist essentiell, damit Sie Ihren Wecker nie verpassen.\n\nWir verwenden nur Benachrichtigungen, um Sie darauf hinzuweisen, wenn Ihr Wecker klingelt. Kein Spam, versprochen.';
	@override String get allow => 'Erlauben';
	@override String get microphonePermission => 'Mikrofon-Berechtigung';
	@override String get microphonePermissionDescription => 'In order to be able to record audio, Echo Wake needs permission to access your microphone. Please continue to the settings to grant permission.';
	@override String get ignore => 'Ignorieren';
	@override String get openSettings => 'Einstellungen öffnen';
	@override String get startRecording => 'Aufnahme starten';
	@override String get voiceRecordings => 'Sprachaufnahmen';
	@override String get continueButton => 'Weiter';
	@override String get manageAppPermissions => 'App-Berechtigungen verwalten';
	@override String get notificationAndMicrophone => 'Benachrichtigungen und Mikrofon';
	@override String get renameRecording => 'Aufnahme umbenennen';
	@override String get newName => 'Neuer Name';
	@override String get recordingNameCannotBeEmpty => 'Der Name der Aufnahme darf nicht leer sein';
	@override String get aRecordingWithThisNameAlreadyExists => 'Eine Aufnahme mit diesem Namen existiert bereits';
	@override String get save => 'Speichern';
	@override String get warningNotificationOnKillDescription => 'Ihre Wecker können nicht klingeln, wenn die App geschlossen wird. Tippen Sie hier, um die App neu zu öffnen.';
	@override String get theme => 'Thema';
	@override String get selectTheThemeForTheApp => 'Wählen Sie das Thema für die App';
	@override String get system => 'System';
	@override String get light => 'Hell';
	@override String get dark => 'Dunkel';
	@override String get snooze => 'Snooze';
	@override String get snoozeDuration => 'Snooze-Dauer';
	@override String get snoozeDurationPicker => 'Snooze-Dauer auswählen';
	@override String get snoozeDurationPickerDescription => 'Minuten vor dem nächsten Wecker';
	@override String get minutes => 'Minuten';
}

// Path: onboarding1
class _TranslationsOnboarding1De implements TranslationsOnboarding1En {
	_TranslationsOnboarding1De._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nehmen Sie Ihren Morgen-Boost auf';
	@override String get description => 'Ihre Stimme, Ihre Energie, Ihre Nachricht zum Aufwachen.';
}

// Path: onboarding2
class _TranslationsOnboarding2De implements TranslationsOnboarding2En {
	_TranslationsOnboarding2De._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stellen Sie Ihren Wecker';
	@override String get description => 'Und verbinden Sie ihn mit Ihrer motivierenden Aufnahme.';
}

// Path: onboarding3
class _TranslationsOnboarding3De implements TranslationsOnboarding3En {
	_TranslationsOnboarding3De._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wachen Sie auf';
	@override String get description => 'Starten Sie Ihren Tag mit Ihren eigenen Worten.';
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
			case 'settings': return 'Einstellungen';
			case 'language': return 'Sprache';
			case 'reportBugOrFeature': return 'Fehler melden oder Funktion anfragen';
			case 'privacyDescription': return 'Keine Daten werden gesammelt. Alles bleibt auf Ihrem Gerät.';
			case 'builtWithLove': return 'Mit ❤️ von Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Leichte Vibration beim Tippen auf Schaltflächen';
			case 'privacy': return 'Datenschutz';
			case 'onboarding1.title': return 'Nehmen Sie Ihren Morgen-Boost auf';
			case 'onboarding1.description': return 'Ihre Stimme, Ihre Energie, Ihre Nachricht zum Aufwachen.';
			case 'onboarding2.title': return 'Stellen Sie Ihren Wecker';
			case 'onboarding2.description': return 'Und verbinden Sie ihn mit Ihrer motivierenden Aufnahme.';
			case 'onboarding3.title': return 'Wachen Sie auf';
			case 'onboarding3.description': return 'Starten Sie Ihren Tag mit Ihren eigenen Worten.';
			case 'skip': return 'Überspringen';
			case 'getStarted': return 'Los geht\'s';
			case 'allowNotifications': return 'Benachrichtigungen erlauben';
			case 'allowNotificationsDescription': return 'Um sicherzustellen, dass Ihr Wecker zuverlässig funktioniert, benötigt Echo Wake Ihre Erlaubnis, Ihnen Benachrichtigungen zu senden. Dies ist essentiell, damit Sie Ihren Wecker nie verpassen.\n\nWir verwenden nur Benachrichtigungen, um Sie darauf hinzuweisen, wenn Ihr Wecker klingelt. Kein Spam, versprochen.';
			case 'allow': return 'Erlauben';
			case 'microphonePermission': return 'Mikrofon-Berechtigung';
			case 'microphonePermissionDescription': return 'In order to be able to record audio, Echo Wake needs permission to access your microphone. Please continue to the settings to grant permission.';
			case 'ignore': return 'Ignorieren';
			case 'openSettings': return 'Einstellungen öffnen';
			case 'startRecording': return 'Aufnahme starten';
			case 'voiceRecordings': return 'Sprachaufnahmen';
			case 'continueButton': return 'Weiter';
			case 'manageAppPermissions': return 'App-Berechtigungen verwalten';
			case 'notificationAndMicrophone': return 'Benachrichtigungen und Mikrofon';
			case 'renameRecording': return 'Aufnahme umbenennen';
			case 'newName': return 'Neuer Name';
			case 'recordingNameCannotBeEmpty': return 'Der Name der Aufnahme darf nicht leer sein';
			case 'aRecordingWithThisNameAlreadyExists': return 'Eine Aufnahme mit diesem Namen existiert bereits';
			case 'save': return 'Speichern';
			case 'warningNotificationOnKillDescription': return 'Ihre Wecker können nicht klingeln, wenn die App geschlossen wird. Tippen Sie hier, um die App neu zu öffnen.';
			case 'theme': return 'Thema';
			case 'selectTheThemeForTheApp': return 'Wählen Sie das Thema für die App';
			case 'system': return 'System';
			case 'light': return 'Hell';
			case 'dark': return 'Dunkel';
			case 'snooze': return 'Snooze';
			case 'snoozeDuration': return 'Snooze-Dauer';
			case 'snoozeDurationPicker': return 'Snooze-Dauer auswählen';
			case 'snoozeDurationPickerDescription': return 'Minuten vor dem nächsten Wecker';
			case 'minutes': return 'Minuten';
			default: return null;
		}
	}
}

