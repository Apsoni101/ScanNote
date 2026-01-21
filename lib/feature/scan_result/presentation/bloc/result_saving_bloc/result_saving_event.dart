part of 'result_saving_bloc.dart';

@immutable
sealed class ResultSavingEvent extends Equatable {
  const ResultSavingEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class OnConfirmationLoadSheets extends ResultSavingEvent {
  const OnConfirmationLoadSheets();
}

final class OnConfirmationSheetSelected extends ResultSavingEvent {
  const OnConfirmationSheetSelected(this.sheetId);

  final String sheetId;

  @override
  List<Object?> get props => <Object?>[sheetId];
}

final class OnConfirmationSheetNameChanged extends ResultSavingEvent {
  const OnConfirmationSheetNameChanged(this.sheetName);

  final String sheetName;

  @override
  List<Object?> get props => <Object?>[sheetName];
}

final class OnConfirmationModeToggled extends ResultSavingEvent {
  const OnConfirmationModeToggled(this.isCreating);

  final bool isCreating;

  @override
  List<Object?> get props => <Object?>[isCreating];
}

final class OnConfirmationCreateSheet extends ResultSavingEvent {
  const OnConfirmationCreateSheet();
}

class OnConfirmationSaveScan extends ResultSavingEvent {
  const OnConfirmationSaveScan(this.scanEntity, this.sheetId, this.sheetTitle);

  final ScanResultEntity scanEntity;
  final String sheetId;
  final String sheetTitle;
}
