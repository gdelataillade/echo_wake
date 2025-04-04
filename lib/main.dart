import 'package:echo_wake/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alarm/alarm.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../domain/services/storage.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';
import '../../../presentation/blocs/alarm/alarm_bloc.dart';
import '../../../presentation/blocs/recording/recordings_bloc.dart';
import '../../../presentation/blocs/recording/recordings_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permissions
  await Permission.notification.request();

  final storage = await StorageService.getInstance();
  await Alarm.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  NavigationBloc(storage: storage)..add(LoadNavigationState()),
        ),
        BlocProvider(create: (context) => AlarmBloc()..add(LoadAlarms())),
        BlocProvider(
          create:
              (context) =>
                  RecordingsBloc(storage: storage)..add(LoadRecordings()),
        ),
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
