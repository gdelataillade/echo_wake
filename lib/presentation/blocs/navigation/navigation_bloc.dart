import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/services/storage.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  static const String selectedTabIndex = 'selectedTabIndex';
  final StorageService _storage;

  NavigationBloc({required StorageService storage})
    : _storage = storage,
      super(const NavigationInitial()) {
    on<LoadNavigationState>(_onLoadNavigationState);
    on<UpdateSelectedTab>(_onUpdateSelectedTab);
  }

  Future<void> _onLoadNavigationState(
    LoadNavigationState event,
    Emitter<NavigationState> emit,
  ) async {
    final savedIndex = _storage.getInt(selectedTabIndex) ?? 0;
    emit(NavigationLoaded(savedIndex));
  }

  Future<void> _onUpdateSelectedTab(
    UpdateSelectedTab event,
    Emitter<NavigationState> emit,
  ) async {
    await _storage.setInt(selectedTabIndex, event.index);
    emit(NavigationLoaded(event.index));
  }
}
