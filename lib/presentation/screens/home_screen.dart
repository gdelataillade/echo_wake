import 'package:flutter/material.dart';
import 'alarm/alarm_screen.dart';
import 'recordings/recording_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body:
              [const AlarmScreen(), const RecordingScreen()][state.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedTab,
            onTap: (index) {
              context.read<NavigationBloc>().add(UpdateSelectedTab(index));
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarms'),
              BottomNavigationBarItem(
                icon: Icon(Icons.mic),
                label: 'Recordings',
              ),
            ],
          ),
        );
      },
    );
  }
}
