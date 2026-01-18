import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc()
      : super(const ResultScanInitial()) {
    on<OnResultCommentChanged>(_onCommentChanged);
  }

  void _onCommentChanged(
      final OnResultCommentChanged event,
      final Emitter<ResultState> emit,
      ) {
    emit(state.copyWith(comment: event.comment));
  }
}
