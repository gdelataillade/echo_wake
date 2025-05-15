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
	@override String get privacyDescription => 'Nenhuma informação é coletada. Tudo fica no seu dispositivo.';
	@override String get builtWithLove => 'Feito com ❤️ por Gautier de Lataillade';
	@override String get hapticFeedback => 'Haptic feedback';
	@override String get hapticFeedbackDescription => 'Leve vibração ao tocar nos botões';
	@override String get privacy => 'Privacidade';
	@override late final _TranslationsOnboarding1Pt onboarding1 = _TranslationsOnboarding1Pt._(_root);
	@override late final _TranslationsOnboarding2Pt onboarding2 = _TranslationsOnboarding2Pt._(_root);
	@override late final _TranslationsOnboarding3Pt onboarding3 = _TranslationsOnboarding3Pt._(_root);
	@override String get skip => 'Pular';
	@override String get getStarted => 'Começar';
	@override String get allowNotifications => 'Permitir notificações';
	@override String get allowNotificationsDescription => 'Para garantir que seu alarme funcione de forma confiável, o Echo Wake precisa de sua permissão para enviar notificações. Isso é essencial para garantir que você nunca perca sua chamada de alarme!\n\nUsamos apenas notificações para alertá-lo quando o seu alarme toca. Não há spam, prometido.';
	@override String get allow => 'Permitir';
	@override String get microphonePermission => 'Permissão de microfone';
	@override String get microphonePermissionDescription => 'Para gravar áudio, o Echo Wake precisa de sua permissão para acessar o seu microfone. Por favor, continue para as configurações para conceder a permissão.';
	@override String get ignore => 'Ignorar';
	@override String get openSettings => 'Abrir configurações';
	@override String get startRecording => 'Gravar';
	@override String get voiceRecordings => 'Gravações de voz';
	@override String get continueButton => 'Continuar';
	@override String get manageAppPermissions => 'Gerenciar permissões da app';
	@override String get notificationAndMicrophone => 'Notificações e microfone';
	@override String get renameRecording => 'Renomear gravação';
	@override String get newName => 'Novo nome';
	@override String get recordingNameCannotBeEmpty => 'O nome da gravação não pode estar vazio';
	@override String get aRecordingWithThisNameAlreadyExists => 'Já existe uma gravação com este nome';
	@override String get save => 'Salvar';
	@override String get warningNotificationOnKillDescription => 'Seu alarme pode não tocar se a app for fechada. Clique aqui para abrir a app.';
	@override String get theme => 'Tema';
	@override String get selectTheThemeForTheApp => 'Selecione o tema para a app';
	@override String get system => 'Sistema';
	@override String get light => 'Claro';
	@override String get dark => 'Escuro';
	@override String get snooze => 'Snooze';
	@override String get snoozeDuration => 'Duração do snooze';
	@override String get snoozeDurationPicker => 'Selecionar a duração do snooze';
	@override String get snoozeDurationPickerDescription => 'Minutos antes que o alarme toque novamente';
	@override String get minutes => 'minutos';
	@override String get recordingDeleted => 'Gravação excluída';
	@override String get cannotDeleteRecordingLinkedToAlarm => 'Não é possível excluir: esta gravação está associada a um alarme. Exclua o alarme primeiro.';
}

// Path: onboarding1
class _TranslationsOnboarding1Pt implements TranslationsOnboarding1En {
	_TranslationsOnboarding1Pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Grave seu impulso matinal';
	@override String get description => 'Sua voz, sua energia, sua mensagem para acordar.';
}

// Path: onboarding2
class _TranslationsOnboarding2Pt implements TranslationsOnboarding2En {
	_TranslationsOnboarding2Pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Defina o alarme';
	@override String get description => 'E associe sua gravação motivacional.';
}

// Path: onboarding3
class _TranslationsOnboarding3Pt implements TranslationsOnboarding3En {
	_TranslationsOnboarding3Pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acorde';
	@override String get description => 'Comece o dia com as suas próprias palavras.';
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
			case 'privacyDescription': return 'Nenhuma informação é coletada. Tudo fica no seu dispositivo.';
			case 'builtWithLove': return 'Feito com ❤️ por Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Leve vibração ao tocar nos botões';
			case 'privacy': return 'Privacidade';
			case 'onboarding1.title': return 'Grave seu impulso matinal';
			case 'onboarding1.description': return 'Sua voz, sua energia, sua mensagem para acordar.';
			case 'onboarding2.title': return 'Defina o alarme';
			case 'onboarding2.description': return 'E associe sua gravação motivacional.';
			case 'onboarding3.title': return 'Acorde';
			case 'onboarding3.description': return 'Comece o dia com as suas próprias palavras.';
			case 'skip': return 'Pular';
			case 'getStarted': return 'Começar';
			case 'allowNotifications': return 'Permitir notificações';
			case 'allowNotificationsDescription': return 'Para garantir que seu alarme funcione de forma confiável, o Echo Wake precisa de sua permissão para enviar notificações. Isso é essencial para garantir que você nunca perca sua chamada de alarme!\n\nUsamos apenas notificações para alertá-lo quando o seu alarme toca. Não há spam, prometido.';
			case 'allow': return 'Permitir';
			case 'microphonePermission': return 'Permissão de microfone';
			case 'microphonePermissionDescription': return 'Para gravar áudio, o Echo Wake precisa de sua permissão para acessar o seu microfone. Por favor, continue para as configurações para conceder a permissão.';
			case 'ignore': return 'Ignorar';
			case 'openSettings': return 'Abrir configurações';
			case 'startRecording': return 'Gravar';
			case 'voiceRecordings': return 'Gravações de voz';
			case 'continueButton': return 'Continuar';
			case 'manageAppPermissions': return 'Gerenciar permissões da app';
			case 'notificationAndMicrophone': return 'Notificações e microfone';
			case 'renameRecording': return 'Renomear gravação';
			case 'newName': return 'Novo nome';
			case 'recordingNameCannotBeEmpty': return 'O nome da gravação não pode estar vazio';
			case 'aRecordingWithThisNameAlreadyExists': return 'Já existe uma gravação com este nome';
			case 'save': return 'Salvar';
			case 'warningNotificationOnKillDescription': return 'Seu alarme pode não tocar se a app for fechada. Clique aqui para abrir a app.';
			case 'theme': return 'Tema';
			case 'selectTheThemeForTheApp': return 'Selecione o tema para a app';
			case 'system': return 'Sistema';
			case 'light': return 'Claro';
			case 'dark': return 'Escuro';
			case 'snooze': return 'Snooze';
			case 'snoozeDuration': return 'Duração do snooze';
			case 'snoozeDurationPicker': return 'Selecionar a duração do snooze';
			case 'snoozeDurationPickerDescription': return 'Minutos antes que o alarme toque novamente';
			case 'minutes': return 'minutos';
			case 'recordingDeleted': return 'Gravação excluída';
			case 'cannotDeleteRecordingLinkedToAlarm': return 'Não é possível excluir: esta gravação está associada a um alarme. Exclua o alarme primeiro.';
			default: return null;
		}
	}
}

