import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_scanner_practice/core/services/image_picker_service.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

part 'qr_scanning_event.dart';

part 'qr_scanning_state.dart';

class QrScanningBloc extends Bloc<QrScanningEvent, QrScanningState> {
  QrScanningBloc({required final ImagePickerService imagePickerService})
    : _imagePickerService = imagePickerService,
      super(const QrScanningState()) {
    on<QrDetectedEvent>(_onQrDetected);
    on<ToggleFlashEvent>(_onToggleFlash);
    on<ScanQrFromGalleryEvent>(_onScanQrFromGallery);
    on<ScanQrFromCameraEvent>(_onScanQrFromCamera);
    on<ResetNavigationEvent>(_onResetNavigation);
  }

  final ImagePickerService _imagePickerService;

  bool _hasNavigated = false;

  Future<void> _onQrDetected(
    final QrDetectedEvent event,
    final Emitter<QrScanningState> emit,
  ) async {
    if (_hasNavigated) {
      return;
    }

    _hasNavigated = true;

    emit(state.copyWith(qrDetected: event.code, isLoading: false));
  }

  Future<void> _onToggleFlash(
    final ToggleFlashEvent event,
    final Emitter<QrScanningState> emit,
  ) async {
    emit(state.copyWith(isFlashOn: !state.isFlashOn));
  }

  Future<void> _onScanQrFromGallery(
    final ScanQrFromGalleryEvent event,
    final Emitter<QrScanningState> emit,
  ) async {
    if (state.isProcessingImage) {
      return;
    }

    emit(state.copyWith(isProcessingImage: true));

    final Either<Failure, String> result = await _imagePickerService
        .pickImageFromGallery();

    result.fold(
      (final Failure failure) {
        emit(state.copyWith(isProcessingImage: false, error: failure.message));
      },
      (final String imagePath) {
        emit(state.copyWith(isProcessingImage: false, imagePath: imagePath));
      },
    );
  }

  Future<void> _onScanQrFromCamera(
    final ScanQrFromCameraEvent event,
    final Emitter<QrScanningState> emit,
  ) async {
    if (state.isProcessingImage) {
      return;
    }

    emit(state.copyWith(isProcessingImage: true));

    final Either<Failure, String> result = await _imagePickerService
        .pickImageFromCamera();

    result.fold(
      (final Failure failure) {
        emit(state.copyWith(isProcessingImage: false, error: failure.message));
      },
      (final String imagePath) {
        emit(state.copyWith(isProcessingImage: false, imagePath: imagePath));
      },
    );
  }

  Future<void> _onResetNavigation(
    final ResetNavigationEvent event,
    final Emitter<QrScanningState> emit,
  ) async {
    _hasNavigated = false;
    emit(state.copyWith());
  }
}
