part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final int selectedTab;

  const NavigationState(this.selectedTab);

  @override
  List<Object> get props => [selectedTab];
}

class NavigationInitial extends NavigationState {
  const NavigationInitial() : super(0);
}

class NavigationLoaded extends NavigationState {
  const NavigationLoaded(super.selectedTab);
}
