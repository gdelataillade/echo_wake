part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class LoadNavigationState extends NavigationEvent {}

class UpdateSelectedTab extends NavigationEvent {
  final int index;

  const UpdateSelectedTab(this.index);

  @override
  List<Object> get props => [index];
}
