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
	@override String get settings => 'Paramètres';
	@override String get language => 'Langue';
	@override String get reportBugOrFeature => 'Signaler un bug ou demander une fonctionnalité';
	@override String get privacyDescription => 'Aucune donnée collectée, tout reste sur votre appareil. 100% hors ligne.';
	@override String get builtWithLove => 'Fait avec ❤️ par Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Légère vibration lors de l\'appui sur les boutons';
	@override String get privacy => 'Confidentialité';
	@override late final _TranslationsOnboarding1Fr onboarding1 = _TranslationsOnboarding1Fr._(_root);
	@override late final _TranslationsOnboarding2Fr onboarding2 = _TranslationsOnboarding2Fr._(_root);
	@override late final _TranslationsOnboarding3Fr onboarding3 = _TranslationsOnboarding3Fr._(_root);
	@override String get skip => 'Passer';
	@override String get getStarted => 'Commencer';
	@override String get allowNotifications => 'Autoriser les notifications';
	@override String get allowNotificationsDescription => 'Pour s\'assurer que votre réveil fonctionne de manière fiable, Echo Wake a besoin de votre permission pour vous envoyer des notifications. C\'est essentiel pour vous assurer de ne pas manquer votre réveil !\n\nNous utilisons uniquement les notifications pour vous informer lorsque votre réveil sonne. Pas de spam, promis.';
	@override String get allow => 'Autoriser';
	@override String get microphonePermission => 'Permission du microphone';
	@override String get microphonePermissionDescription => 'Pour enregistrer de l\'audio, Echo Wake a besoin de votre permission pour accéder à votre microphone. Veuillez continuer aux paramètres pour accorder la permission.';
	@override String get ignore => 'Ignorer';
	@override String get openSettings => 'Ouvrir les paramètres';
	@override String get startRecording => 'Enregistrer';
	@override String get voiceRecordings => 'Enregistrements';
	@override String get continueButton => 'Continuer';
	@override String get manageAppPermissions => 'Gérer les permissions de l\'app';
	@override String get notificationAndMicrophone => 'Notifications et microphone';
	@override String get renameRecording => 'Renommer l\'enregistrement';
	@override String get newName => 'Nouveau nom';
	@override String get recordingNameCannotBeEmpty => 'Le nom de l\'enregistrement ne peut pas être vide';
	@override String get aRecordingWithThisNameAlreadyExists => 'Un enregistrement avec ce nom existe déjà';
	@override String get save => 'Enregistrer';
	@override String get warningNotificationOnKillDescription => 'Vos alarmes peuvent ne pas sonner si l\'app est fermée. Cliquez ici pour ouvrir l\'app.';
	@override String get theme => 'Thème';
	@override String get selectTheThemeForTheApp => 'Sélectionnez le thème de l\'app';
	@override String get system => 'Système';
	@override String get light => 'Clair';
	@override String get dark => 'Sombre';
}

// Path: onboarding1
class _TranslationsOnboarding1Fr implements TranslationsOnboarding1En {
	_TranslationsOnboarding1Fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enregistrez votre boost du matin';
	@override String get description => 'Votre voix, votre énergie, votre message pour vous réveiller.';
}

// Path: onboarding2
class _TranslationsOnboarding2Fr implements TranslationsOnboarding2En {
	_TranslationsOnboarding2Fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Programmez votre réveil';
	@override String get description => 'Et associez-le à votre enregistrement motivant.';
}

// Path: onboarding3
class _TranslationsOnboarding3Fr implements TranslationsOnboarding3En {
	_TranslationsOnboarding3Fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réveillez-vous';
	@override String get description => 'Commencez votre journée avec vos propres mots.';
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
			case 'settings': return 'Paramètres';
			case 'language': return 'Langue';
			case 'reportBugOrFeature': return 'Signaler un bug ou demander une fonctionnalité';
			case 'privacyDescription': return 'Aucune donnée collectée, tout reste sur votre appareil. 100% hors ligne.';
			case 'builtWithLove': return 'Fait avec ❤️ par Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Légère vibration lors de l\'appui sur les boutons';
			case 'privacy': return 'Confidentialité';
			case 'onboarding1.title': return 'Enregistrez votre boost du matin';
			case 'onboarding1.description': return 'Votre voix, votre énergie, votre message pour vous réveiller.';
			case 'onboarding2.title': return 'Programmez votre réveil';
			case 'onboarding2.description': return 'Et associez-le à votre enregistrement motivant.';
			case 'onboarding3.title': return 'Réveillez-vous';
			case 'onboarding3.description': return 'Commencez votre journée avec vos propres mots.';
			case 'skip': return 'Passer';
			case 'getStarted': return 'Commencer';
			case 'allowNotifications': return 'Autoriser les notifications';
			case 'allowNotificationsDescription': return 'Pour s\'assurer que votre réveil fonctionne de manière fiable, Echo Wake a besoin de votre permission pour vous envoyer des notifications. C\'est essentiel pour vous assurer de ne pas manquer votre réveil !\n\nNous utilisons uniquement les notifications pour vous informer lorsque votre réveil sonne. Pas de spam, promis.';
			case 'allow': return 'Autoriser';
			case 'microphonePermission': return 'Permission du microphone';
			case 'microphonePermissionDescription': return 'Pour enregistrer de l\'audio, Echo Wake a besoin de votre permission pour accéder à votre microphone. Veuillez continuer aux paramètres pour accorder la permission.';
			case 'ignore': return 'Ignorer';
			case 'openSettings': return 'Ouvrir les paramètres';
			case 'startRecording': return 'Enregistrer';
			case 'voiceRecordings': return 'Enregistrements';
			case 'continueButton': return 'Continuer';
			case 'manageAppPermissions': return 'Gérer les permissions de l\'app';
			case 'notificationAndMicrophone': return 'Notifications et microphone';
			case 'renameRecording': return 'Renommer l\'enregistrement';
			case 'newName': return 'Nouveau nom';
			case 'recordingNameCannotBeEmpty': return 'Le nom de l\'enregistrement ne peut pas être vide';
			case 'aRecordingWithThisNameAlreadyExists': return 'Un enregistrement avec ce nom existe déjà';
			case 'save': return 'Enregistrer';
			case 'warningNotificationOnKillDescription': return 'Vos alarmes peuvent ne pas sonner si l\'app est fermée. Cliquez ici pour ouvrir l\'app.';
			case 'theme': return 'Thème';
			case 'selectTheThemeForTheApp': return 'Sélectionnez le thème de l\'app';
			case 'system': return 'Système';
			case 'light': return 'Clair';
			case 'dark': return 'Sombre';
			default: return null;
		}
	}
}

