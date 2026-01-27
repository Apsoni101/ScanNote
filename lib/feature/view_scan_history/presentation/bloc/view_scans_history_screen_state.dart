part of 'view_scans_history_screen_bloc.dart';

class ViewScansHistoryScreenState extends Equatable {
  const ViewScansHistoryScreenState({
    this.isLoading = false,
    this.allScans = const <PendingSyncEntity>[],
    this.searchQuery = '',
    this.error,
    this.isLoadingMoreSheets = false,
    this.hasMoreSheets = true,
    this.nextPageToken,
  });

  final bool isLoading;
  final List<PendingSyncEntity> allScans;
  final String searchQuery;
  final String? error;
  final bool isLoadingMoreSheets;
  final bool hasMoreSheets;
  final String? nextPageToken;

  ViewScansHistoryScreenState copyWith({
    final bool? isLoading,
    final bool? isRefreshing,
    final List<PendingSyncEntity>? allScans,
    final String? searchQuery,
    final String? error,
    final bool? isLoadingMoreSheets,
    final bool? hasMoreSheets,
    final String? nextPageToken,
  }) {
    return ViewScansHistoryScreenState(
      isLoading: isLoading ?? this.isLoading,
      allScans: allScans ?? this.allScans,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
      isLoadingMoreSheets: isLoadingMoreSheets ?? this.isLoadingMoreSheets,
      hasMoreSheets: hasMoreSheets ?? this.hasMoreSheets,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    allScans,
    searchQuery,
    error,
    isLoadingMoreSheets,
    hasMoreSheets,
    nextPageToken,
  ];
}

class HistoryScreenInitial extends ViewScansHistoryScreenState {
  const HistoryScreenInitial();
}
