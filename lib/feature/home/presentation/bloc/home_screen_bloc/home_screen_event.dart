part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class OnHomeLoadInitial extends HomeScreenEvent {
  const OnHomeLoadInitial();
}

final class OnHomeSyncPendingScans extends HomeScreenEvent {
  const OnHomeSyncPendingScans();
}

final class OnHomeRefreshSheets extends HomeScreenEvent {
  const OnHomeRefreshSheets();
}

final class OnHomeNetworkStatusChanged extends HomeScreenEvent {
  const OnHomeNetworkStatusChanged(this.isConnected);

  final bool isConnected;

  @override
  List<Object?> get props => <Object?>[isConnected];
}

final class OnHomeResetSyncSuccess extends HomeScreenEvent {
  const OnHomeResetSyncSuccess();
}

final class OnHomeResetSyncError extends HomeScreenEvent {
  const OnHomeResetSyncError();
}

final class OnHomeResetError extends HomeScreenEvent {
  const OnHomeResetError();
}

final class OnHomeUpdatePendingCount extends HomeScreenEvent {
  const OnHomeUpdatePendingCount();
}
