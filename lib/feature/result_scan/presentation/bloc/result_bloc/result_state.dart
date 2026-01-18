part of 'result_bloc.dart';

@immutable
class ResultState extends Equatable {
  const ResultState({this.comment = ''});

  final String comment;

  ResultState copyWith({final String? comment}) {
    return ResultState(comment: comment ?? this.comment);
  }

  @override
  List<Object?> get props => <Object?>[comment];
}

class ResultScanInitial extends ResultState {
  const ResultScanInitial();
}
