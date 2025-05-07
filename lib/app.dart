import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/presentation/screens/home_screen.dart';
import 'package:echo_wake/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _hasSeenOnboarding() async {
    final storage = await StorageService.getInstance();
    return storage.getBool('hasSeenOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo Wake',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _hasSeenOnboarding(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final shouldShowOnboarding = snapshot.data == false;
          if (shouldShowOnboarding) {
            return const OnboardingScreen();
          }
          return const HomeScreen();
        },
      ),
    );
  }
}
