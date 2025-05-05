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
			default: return null;
		}
	}
}

