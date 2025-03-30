import 'package:flutter/material.dart';
import 'alarms_screen.dart';
import 'recordings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/blocs/navigation/navigation_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.selectedTab == 0 ? 'Alarms' : 'Recordings'),
          ),
          body: [AlarmsScreen(), RecordingsScreen()][state.selectedTab],
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
