part of 'view_scans_history_screen_bloc.dart';

class ViewScansHistoryScreenState extends Equatable {
  const ViewScansHistoryScreenState({
    this.isLoading = false,
    this.allScans = const <PendingSyncEntity>[],
    this.filteredScans = const <PendingSyncEntity>[],
    this.searchQuery = '',
    this.error,
  });

  final bool isLoading;
  final List<PendingSyncEntity> allScans;
  final List<PendingSyncEntity> filteredScans;
  final String searchQuery;
  final String? error;

  ViewScansHistoryScreenState copyWith({
    final bool? isLoading,
    final bool? isRefreshing,
    final List<PendingSyncEntity>? allScans,
    final List<PendingSyncEntity>? filteredScans,
    final String? searchQuery,
    final String? error,
  }) {
    return ViewScansHistoryScreenState(
      isLoading: isLoading ?? this.isLoading,
      allScans: allScans ?? this.allScans,
      filteredScans: filteredScans ?? this.filteredScans,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    allScans,
    filteredScans,
    searchQuery,
    error,
  ];
}

class HistoryScreenInitial extends ViewScansHistoryScreenState {
  const HistoryScreenInitial();
}
