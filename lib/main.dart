import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/alarm/alarm_cubit.dart';
import 'package:echo_wake/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alarm/alarm.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../domain/services/storage.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';
import '../../../presentation/blocs/recording/recordings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocaleSettings.useDeviceLocale();

  // Request notification permissions
  await Permission.notification.request();

  final storage = await StorageService.getInstance();
  await Alarm.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit(storage: storage)),
        BlocProvider(create: (context) => AlarmCubit()),
        BlocProvider(create: (context) => RecordingsCubit(storage: storage)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo Wake',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
