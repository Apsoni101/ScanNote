part of 'history_screen_bloc.dart';

@immutable
sealed class HistoryScreenEvent extends Equatable {
  const HistoryScreenEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class OnHistoryLoadScans extends HistoryScreenEvent {
  const OnHistoryLoadScans();
}

class OnHistorySearchScans extends HistoryScreenEvent {
  const OnHistorySearchScans(this.query);

  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}

class OnHistoryRefreshScans extends HistoryScreenEvent {
  const OnHistoryRefreshScans();
}
