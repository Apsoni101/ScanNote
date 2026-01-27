part of 'view_scans_history_screen_bloc.dart';

@immutable
sealed class ViewScansHistoryScreenEvent extends Equatable {
  const ViewScansHistoryScreenEvent();

  @override
  List<Object?> get props => [];
}

class OnHistoryLoadScans extends ViewScansHistoryScreenEvent {
  const OnHistoryLoadScans();
}

class OnHistoryLoadMoreScans extends ViewScansHistoryScreenEvent {
  const OnHistoryLoadMoreScans();
}

class OnHistorySearchScans extends ViewScansHistoryScreenEvent {
  const OnHistorySearchScans({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
