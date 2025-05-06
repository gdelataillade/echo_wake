///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get alarms => 'Alarms';
	String get recordings => 'Recordings';
	String get noAlarms => 'No alarms set';
	String get tapPlusToAddAlarm => 'Tap + to add an alarm';
	String get alarmDeleted => 'Alarm deleted';
	String get addAlarm => 'Add alarm';
	String get editAlarm => 'Edit alarm';
	String get stopAlarm => 'Stop alarm';
	String get error => 'Error';
	String get setAlarmTime => 'Set alarm time';
	String get selectAlarmSound => 'Select alarm sound';
	String get playSoundRepeatedlyUntilAlarmStopped => 'Play the sound repeatedly until the alarm is stopped';
	String get customVolume => 'Custom volume';
	String get setSpecificVolumeForThisAlarm => 'Set a specific volume for this alarm';
	String get loopSound => 'Loop sound';
	String get saveChanges => 'Save changes';
	String get cancel => 'Cancel';
	String get setAlarm => 'Set alarm';
	String get recordASound => 'Record a sound';
	String get noRecordingsYet => 'No recordings yet';
	String get settings => 'Settings';
	String get language => 'Language';
	String get reportBugOrFeature => 'Report a bug or ask for a feature';
	String get privacyDescription => 'No data is collected. Everything absolutely stays on your device. No back-end. 100% offline.';
	String get builtWithLove => 'Built with ❤️ by Gautier de Lataillade';
	String get hapticFeedback => 'Haptic feedback';
	String get hapticFeedbackDescription => 'Light vibration when tapping on buttons';
	String get privacy => 'Privacy';
	late final TranslationsOnboarding1En onboarding1 = TranslationsOnboarding1En._(_root);
	late final TranslationsOnboarding2En onboarding2 = TranslationsOnboarding2En._(_root);
	late final TranslationsOnboarding3En onboarding3 = TranslationsOnboarding3En._(_root);
	String get skip => 'Skip';
	String get getStarted => 'Get Started';
}

// Path: onboarding1
class TranslationsOnboarding1En {
	TranslationsOnboarding1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Record your morning boost';
	String get description => 'Your voice, your energy, your message to wake up to.';
}

// Path: onboarding2
class TranslationsOnboarding2En {
	TranslationsOnboarding2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Set your alarm';
	String get description => 'And link it to your motivating recording.';
}

// Path: onboarding3
class TranslationsOnboarding3En {
	TranslationsOnboarding3En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Wake up';
	String get description => 'Start your day with your own words.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'alarms': return 'Alarms';
			case 'recordings': return 'Recordings';
			case 'noAlarms': return 'No alarms set';
			case 'tapPlusToAddAlarm': return 'Tap + to add an alarm';
			case 'alarmDeleted': return 'Alarm deleted';
			case 'addAlarm': return 'Add alarm';
			case 'editAlarm': return 'Edit alarm';
			case 'stopAlarm': return 'Stop alarm';
			case 'error': return 'Error';
			case 'setAlarmTime': return 'Set alarm time';
			case 'selectAlarmSound': return 'Select alarm sound';
			case 'playSoundRepeatedlyUntilAlarmStopped': return 'Play the sound repeatedly until the alarm is stopped';
			case 'customVolume': return 'Custom volume';
			case 'setSpecificVolumeForThisAlarm': return 'Set a specific volume for this alarm';
			case 'loopSound': return 'Loop sound';
			case 'saveChanges': return 'Save changes';
			case 'cancel': return 'Cancel';
			case 'setAlarm': return 'Set alarm';
			case 'recordASound': return 'Record a sound';
			case 'noRecordingsYet': return 'No recordings yet';
			case 'settings': return 'Settings';
			case 'language': return 'Language';
			case 'reportBugOrFeature': return 'Report a bug or ask for a feature';
			case 'privacyDescription': return 'No data is collected. Everything absolutely stays on your device. No back-end. 100% offline.';
			case 'builtWithLove': return 'Built with ❤️ by Gautier de Lataillade';
			case 'hapticFeedback': return 'Haptic feedback';
			case 'hapticFeedbackDescription': return 'Light vibration when tapping on buttons';
			case 'privacy': return 'Privacy';
			case 'onboarding1.title': return 'Record your morning boost';
			case 'onboarding1.description': return 'Your voice, your energy, your message to wake up to.';
			case 'onboarding2.title': return 'Set your alarm';
			case 'onboarding2.description': return 'And link it to your motivating recording.';
			case 'onboarding3.title': return 'Wake up';
			case 'onboarding3.description': return 'Start your day with your own words.';
			case 'skip': return 'Skip';
			case 'getStarted': return 'Get Started';
			default: return null;
		}
	}
}

