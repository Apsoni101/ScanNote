part of 'history_screen_bloc.dart';

class HistoryScreenState extends Equatable {
  const HistoryScreenState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.allScans = const <PendingSyncEntity>[],
    this.filteredScans = const <PendingSyncEntity>[],
    this.searchQuery = '',
    this.error,
  });

  final bool isLoading;
  final bool isRefreshing;
  final List<PendingSyncEntity> allScans;
  final List<PendingSyncEntity> filteredScans;
  final String searchQuery;
  final String? error;

  HistoryScreenState copyWith({
    final bool? isLoading,
    final bool? isRefreshing,
    final List<PendingSyncEntity>? allScans,
    final List<PendingSyncEntity>? filteredScans,
    final String? searchQuery,
    final String? error,
  }) {
    return HistoryScreenState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      allScans: allScans ?? this.allScans,
      filteredScans: filteredScans ?? this.filteredScans,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    isRefreshing,
    allScans,
    filteredScans,
    searchQuery,
    error,
  ];
}

class HistoryScreenInitial extends HistoryScreenState {
  const HistoryScreenInitial();
}
