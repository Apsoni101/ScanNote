part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState extends Equatable {
  const HomeScreenState({
    required this.isLoading,
    required this.isSyncing,
    required this.isOnline,
    required this.pendingSyncCount,
    required this.showSyncSuccess,
    this.syncError,
    this.error,
  });

  final bool isLoading;
  final bool isSyncing;
  final bool isOnline;
  final int pendingSyncCount;
  final bool showSyncSuccess;
  final String? syncError;
  final String? error;

  HomeScreenState copyWith({
    final bool? isLoading,
    final bool? isSyncing,
    final bool? isOnline,
    final int? pendingSyncCount,
    final bool? showSyncSuccess,
    final String? syncError,
    final String? error,
  });

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    isSyncing,
    isOnline,
    pendingSyncCount,
    showSyncSuccess,
    syncError,
    error,
  ];
}

final class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial()
    : super(
        isLoading: false,
        isSyncing: false,
        isOnline: true,
        pendingSyncCount: 0,
        showSyncSuccess: false,
        syncError: null,
        error: null,
      );

  @override
  HomeScreenState copyWith({
    final bool? isLoading,
    final bool? isSyncing,
    final bool? isOnline,
    final int? pendingSyncCount,
    final bool? showSyncSuccess,
    final String? syncError,
    final String? error,
  }) {
    return HomeScreenLoaded(
      isLoading: isLoading ?? this.isLoading,
      isSyncing: isSyncing ?? this.isSyncing,
      isOnline: isOnline ?? this.isOnline,
      pendingSyncCount: pendingSyncCount ?? this.pendingSyncCount,
      showSyncSuccess: showSyncSuccess ?? this.showSyncSuccess,
      syncError: syncError,
      error: error,
    );
  }
}

final class HomeScreenLoaded extends HomeScreenState {
  const HomeScreenLoaded({
    required super.isLoading,
    required super.isSyncing,
    required super.isOnline,
    required super.pendingSyncCount,
    required super.showSyncSuccess,
    super.syncError,
    super.error,
  });

  @override
  HomeScreenState copyWith({
    final bool? isLoading,
    final bool? isSyncing,
    final bool? isOnline,
    final int? pendingSyncCount,
    final bool? showSyncSuccess,
    final String? syncError,
    final String? error,
  }) {
    return HomeScreenLoaded(
      isLoading: isLoading ?? this.isLoading,
      isSyncing: isSyncing ?? this.isSyncing,
      isOnline: isOnline ?? this.isOnline,
      pendingSyncCount: pendingSyncCount ?? this.pendingSyncCount,
      showSyncSuccess: showSyncSuccess ?? this.showSyncSuccess,
      syncError: syncError,
      error: error,
    );
  }
}
