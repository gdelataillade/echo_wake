import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/services/storage.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  static const String selectedTabIndex = 'selectedTabIndex';
  final StorageService _storage;

  NavigationCubit({required StorageService storage})
    : _storage = storage,
      super(const NavigationInitial()) {
    loadNavigationState();
  }

  Future<void> loadNavigationState() async {
    final savedIndex = _storage.getInt(selectedTabIndex) ?? 0;
    emit(NavigationLoaded(savedIndex));
  }

  Future<void> updateSelectedTab(int index) async {
    await _storage.setInt(selectedTabIndex, index);
    emit(NavigationLoaded(index));
  }
}
