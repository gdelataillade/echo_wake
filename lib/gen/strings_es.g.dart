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
class TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override String get alarms => 'Alarmas';
	@override String get recordings => 'Grabaciones';
	@override String get noAlarms => 'No hay alarmas configuradas';
	@override String get tapPlusToAddAlarm => 'Toca + para añadir una alarma';
	@override String get alarmDeleted => 'Alarma eliminada';
	@override String get addAlarm => 'Añadir alarma';
	@override String get editAlarm => 'Editar alarma';
	@override String get stopAlarm => 'Detener alarma';
	@override String get error => 'Error';
	@override String get setAlarmTime => 'Establecer hora de la alarma';
	@override String get selectAlarmSound => 'Seleccionar sonido de alarma';
	@override String get playSoundRepeatedlyUntilAlarmStopped => 'Reproducir el sonido repetidamente hasta que se detenga la alarma';
	@override String get customVolume => 'Volumen personalizado';
	@override String get setSpecificVolumeForThisAlarm => 'Establecer un volumen específico para esta alarma';
	@override String get loopSound => 'Repetir sonido';
	@override String get saveChanges => 'Guardar cambios';
	@override String get cancel => 'Cancelar';
	@override String get setAlarm => 'Establecer alarma';
	@override String get recordASound => 'Grabar un sonido';
	@override String get noRecordingsYet => 'Aún no hay grabaciones';
	@override String get settings => 'Configuración';
	@override String get language => 'Idioma';
	@override String get reportBugOrFeature => 'Reportar un bug o solicitar una funcionalidad';
	@override String get privacyDescription => 'No se recopilan datos. Todo permanece en tu dispositivo. No hay servidor. 100% offline.';
	@override String get builtWithLove => 'Hecho con ❤️ por Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Leve vibración al tocar los botones';
	@override String get privacy => 'Privacidad';
	@override late final _TranslationsOnboarding1Es onboarding1 = _TranslationsOnboarding1Es._(_root);
	@override late final _TranslationsOnboarding2Es onboarding2 = _TranslationsOnboarding2Es._(_root);
	@override late final _TranslationsOnboarding3Es onboarding3 = _TranslationsOnboarding3Es._(_root);
	@override String get skip => 'Omitir';
	@override String get getStarted => 'Comenzar';
}

// Path: onboarding1
class _TranslationsOnboarding1Es implements TranslationsOnboarding1En {
	_TranslationsOnboarding1Es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Graba tu impulso matutino';
	@override String get description => 'Tu voz, tu energía, tu mensaje para despertar.';
}

// Path: onboarding2
class _TranslationsOnboarding2Es implements TranslationsOnboarding2En {
	_TranslationsOnboarding2Es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Programa tu alarma';
	@override String get description => 'Y asígnale tu grabación motivadora.';
}

// Path: onboarding3
class _TranslationsOnboarding3Es implements TranslationsOnboarding3En {
	_TranslationsOnboarding3Es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Despiértate';
	@override String get description => 'Empieza el día con tus propias palabras.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'alarms': return 'Alarmas';
			case 'recordings': return 'Grabaciones';
			case 'noAlarms': return 'No hay alarmas configuradas';
			case 'tapPlusToAddAlarm': return 'Toca + para añadir una alarma';
			case 'alarmDeleted': return 'Alarma eliminada';
			case 'addAlarm': return 'Añadir alarma';
			case 'editAlarm': return 'Editar alarma';
			case 'stopAlarm': return 'Detener alarma';
			case 'error': return 'Error';
			case 'setAlarmTime': return 'Establecer hora de la alarma';
			case 'selectAlarmSound': return 'Seleccionar sonido de alarma';
			case 'playSoundRepeatedlyUntilAlarmStopped': return 'Reproducir el sonido repetidamente hasta que se detenga la alarma';
			case 'customVolume': return 'Volumen personalizado';
			case 'setSpecificVolumeForThisAlarm': return 'Establecer un volumen específico para esta alarma';
			case 'loopSound': return 'Repetir sonido';
			case 'saveChanges': return 'Guardar cambios';
			case 'cancel': return 'Cancelar';
			case 'setAlarm': return 'Establecer alarma';
			case 'recordASound': return 'Grabar un sonido';
			case 'noRecordingsYet': return 'Aún no hay grabaciones';
			case 'settings': return 'Configuración';
			case 'language': return 'Idioma';
			case 'reportBugOrFeature': return 'Reportar un bug o solicitar una funcionalidad';
			case 'privacyDescription': return 'No se recopilan datos. Todo permanece en tu dispositivo. No hay servidor. 100% offline.';
			case 'builtWithLove': return 'Hecho con ❤️ por Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Leve vibración al tocar los botones';
			case 'privacy': return 'Privacidad';
			case 'onboarding1.title': return 'Graba tu impulso matutino';
			case 'onboarding1.description': return 'Tu voz, tu energía, tu mensaje para despertar.';
			case 'onboarding2.title': return 'Programa tu alarma';
			case 'onboarding2.description': return 'Y asígnale tu grabación motivadora.';
			case 'onboarding3.title': return 'Despiértate';
			case 'onboarding3.description': return 'Empieza el día con tus propias palabras.';
			case 'skip': return 'Omitir';
			case 'getStarted': return 'Comenzar';
			default: return null;
		}
	}
}

