import 'package:echo_wake/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/services/storage.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await StorageService.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  NavigationBloc(storage: storage)..add(LoadNavigationState()),
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
