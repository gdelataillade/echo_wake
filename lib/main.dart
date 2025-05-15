import 'package:echo_wake/app.dart';
import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:echo_wake/presentation/blocs/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alarm/alarm.dart';
import '../../../domain/services/storage.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';
import '../../../presentation/blocs/recording/recordings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await StorageService.getInstance();
  final storedLanguage = storage.getString('settingsLanguage');
  if (storedLanguage != null) {
    await LocaleSettings.setLocaleRaw(storedLanguage);
  } else {
    await LocaleSettings.useDeviceLocale();
  }

  await Helper.init();
  await Alarm.init();

  runApp(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit(storage: storage)),
          BlocProvider(create: (context) => NavigationCubit(storage: storage)),
          BlocProvider(create: (context) => AlarmCubit()),
          BlocProvider(create: (context) => RecordingsCubit(storage: storage)),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
