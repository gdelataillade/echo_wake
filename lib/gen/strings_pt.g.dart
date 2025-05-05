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
class TranslationsPt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override String get alarms => 'Alarmes';
	@override String get recordings => 'Gravações';
	@override String get noAlarms => 'Nenhum alarme configurado';
	@override String get tapPlusToAddAlarm => 'Toque em + para adicionar um alarme';
	@override String get alarmDeleted => 'Alarme excluído';
	@override String get addAlarm => 'Adicionar alarme';
	@override String get editAlarm => 'Editar alarme';
	@override String get stopAlarm => 'Parar alarme';
	@override String get error => 'Erro';
	@override String get setAlarmTime => 'Definir horário do alarme';
	@override String get selectAlarmSound => 'Selecionar som do alarme';
	@override String get playSoundRepeatedlyUntilAlarmStopped => 'Reproduzir o som repetidamente até o alarme ser parado';
	@override String get customVolume => 'Volume personalizado';
	@override String get setSpecificVolumeForThisAlarm => 'Definir um volume específico para este alarme';
	@override String get loopSound => 'Repetir som';
	@override String get saveChanges => 'Salvar alterações';
	@override String get cancel => 'Cancelar';
	@override String get setAlarm => 'Definir alarme';
	@override String get recordASound => 'Gravar um som';
	@override String get noRecordingsYet => 'Nenhuma gravação ainda';
	@override String get settings => 'Configurações';
	@override String get language => 'Idioma';
	@override String get reportBugOrFeature => 'Reportar um bug ou solicitar uma funcionalidade';
	@override String get privacyDescription => 'Nenhuma informação é coletada. Tudo fica no seu dispositivo. Nenhum servidor. 100% offline.';
	@override String get builtWithLove => 'Feito com ❤️ por Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Leve vibração ao tocar nos botões';
	@override String get privacy => 'Privacidade';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'alarms': return 'Alarmes';
			case 'recordings': return 'Gravações';
			case 'noAlarms': return 'Nenhum alarme configurado';
			case 'tapPlusToAddAlarm': return 'Toque em + para adicionar um alarme';
			case 'alarmDeleted': return 'Alarme excluído';
			case 'addAlarm': return 'Adicionar alarme';
			case 'editAlarm': return 'Editar alarme';
			case 'stopAlarm': return 'Parar alarme';
			case 'error': return 'Erro';
			case 'setAlarmTime': return 'Definir horário do alarme';
			case 'selectAlarmSound': return 'Selecionar som do alarme';
			case 'playSoundRepeatedlyUntilAlarmStopped': return 'Reproduzir o som repetidamente até o alarme ser parado';
			case 'customVolume': return 'Volume personalizado';
			case 'setSpecificVolumeForThisAlarm': return 'Definir um volume específico para este alarme';
			case 'loopSound': return 'Repetir som';
			case 'saveChanges': return 'Salvar alterações';
			case 'cancel': return 'Cancelar';
			case 'setAlarm': return 'Definir alarme';
			case 'recordASound': return 'Gravar um som';
			case 'noRecordingsYet': return 'Nenhuma gravação ainda';
			case 'settings': return 'Configurações';
			case 'language': return 'Idioma';
			case 'reportBugOrFeature': return 'Reportar um bug ou solicitar uma funcionalidade';
			case 'privacyDescription': return 'Nenhuma informação é coletada. Tudo fica no seu dispositivo. Nenhum servidor. 100% offline.';
			case 'builtWithLove': return 'Feito com ❤️ por Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Leve vibração ao tocar nos botões';
			case 'privacy': return 'Privacidade';
			default: return null;
		}
	}
}

