part of 'result_confirmation_bloc.dart';

@immutable
sealed class ResultConfirmationEvent extends Equatable {
  const ResultConfirmationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class OnConfirmationLoadSheets extends ResultConfirmationEvent {
  const OnConfirmationLoadSheets();
}

final class OnConfirmationSheetSelected extends ResultConfirmationEvent {
  const OnConfirmationSheetSelected(this.sheetId);

  final String sheetId;

  @override
  List<Object?> get props => <Object?>[sheetId];
}

final class OnConfirmationSheetNameChanged extends ResultConfirmationEvent {
  const OnConfirmationSheetNameChanged(this.sheetName);

  final String sheetName;

  @override
  List<Object?> get props => <Object?>[sheetName];
}

final class OnConfirmationModeToggled extends ResultConfirmationEvent {
  const OnConfirmationModeToggled(this.isCreating);

  final bool isCreating;

  @override
  List<Object?> get props => <Object?>[isCreating];
}

final class OnConfirmationCreateSheet extends ResultConfirmationEvent {
  const OnConfirmationCreateSheet();
}

class OnConfirmationSaveScan extends ResultConfirmationEvent {
  const OnConfirmationSaveScan(this.scanEntity, this.sheetId, this.sheetTitle);

  final ResultScanEntity scanEntity;
  final String sheetId;
  final String sheetTitle;
}
