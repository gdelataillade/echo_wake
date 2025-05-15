import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    Helper.lightHapticFeedback();

    final storage = await StorageService.getInstance();
    await storage.setBool('hasSeenOnboarding', true);
    if (!context.mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      controllerColor: Colors.deepPurple,
      headerBackgroundColor: Colors.deepPurple,
      finishButtonText: t.getStarted,
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onFinish: () => _completeOnboarding(context),
      skipTextButton: Text(t.skip),
      background: [
        Image.asset(
          'assets/onb1.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        Image.asset(
          'assets/onb2.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        Image.asset(
          'assets/onb3.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
      ],
      totalPage: 3,
      speed: 1.8,
      pageBodies: [
        _OnboardingStep(
          title: t.onboarding1.title,
          description: t.onboarding1.description,
        ),
        _OnboardingStep(
          title: t.onboarding2.title,
          description: t.onboarding2.description,
        ),
        _OnboardingStep(
          title: t.onboarding3.title,
          description: t.onboarding3.description,
        ),
      ],
    );
  }
}

class _OnboardingStep extends StatelessWidget {
  final String title;
  final String description;

  const _OnboardingStep({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            description,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
