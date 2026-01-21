part of 'view_scans_history_screen_bloc.dart';

@immutable
sealed class ViewScansHistoryScreenEvent extends Equatable {
  const ViewScansHistoryScreenEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class OnHistoryLoadScans extends ViewScansHistoryScreenEvent {
  const OnHistoryLoadScans();
}

class OnHistorySearchScans extends ViewScansHistoryScreenEvent {
  const OnHistorySearchScans(this.query);

  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}
