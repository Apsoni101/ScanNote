import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/use_case/ocr_use_case.dart';

part 'ocr_event.dart';

part 'ocr_state.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  OcrBloc({required this.ocrUseCase}) : super(const OcrInitialState()) {
    on<PickImageFromCameraEvent>(_onPickImageFromCamera);
    on<PickImageFromGalleryEvent>(_onPickImageFromGallery);
    on<ClearOcrResultEvent>(_onClearOcrResult);
  }
  final OcrUseCase ocrUseCase;

  Future<void> _onPickImageFromCamera(
    final PickImageFromCameraEvent event,
    final Emitter<OcrState> emit,
  ) async {
    emit(const OcrLoadingState());

    final Either<Failure, String> result = await ocrUseCase.callFromCamera();

    result.fold(
      (final Failure failure) => emit(OcrErrorState(message: failure.message)),
      (final String recognizedText) {
        if (recognizedText.isEmpty) {
          emit(const OcrErrorState(message: 'No text found in the image.'));
        } else {
          emit(OcrSuccessState(result: recognizedText));
        }
      },
    );
  }

  Future<void> _onPickImageFromGallery(
    final PickImageFromGalleryEvent event,
    final Emitter<OcrState> emit,
  ) async {
    emit(const OcrLoadingState());

    final Either<Failure, String> result = await ocrUseCase.callFromGallery();

    result.fold(
      (final Failure failure) => emit(OcrErrorState(message: failure.message)),
      (final String recognizedText) {
        if (recognizedText.isEmpty) {
          emit(const OcrErrorState(message: 'No text found in the image.'));
        } else {
          emit(OcrSuccessState(result: recognizedText));
        }
      },
    );
  }

  Future<void> _onClearOcrResult(
    final ClearOcrResultEvent event,
    final Emitter<OcrState> emit,
  ) async {
    emit(const OcrInitialState());
  }
}
