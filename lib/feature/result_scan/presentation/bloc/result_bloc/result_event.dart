part of 'result_bloc.dart';

@immutable
sealed class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class OnResultCommentChanged extends ResultEvent {
  const OnResultCommentChanged(this.comment);

  final String comment;

  @override
  List<Object?> get props => <Object?>[comment];
}
