part of 'qr_scanning_bloc.dart';

sealed class ResultScanningEvent extends Equatable {
  const ResultScanningEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class QrDetectedEvent extends ResultScanningEvent {
  const QrDetectedEvent(this.code);

  final String code;

  @override
  List<Object?> get props => <Object?>[code];
}

class ToggleFlashEvent extends ResultScanningEvent {
  const ToggleFlashEvent();
}

class ScanQrFromGalleryEvent extends ResultScanningEvent {
  const ScanQrFromGalleryEvent();
}

class ScanQrFromCameraEvent extends ResultScanningEvent {
  const ScanQrFromCameraEvent();
}

class ResetNavigationEvent extends ResultScanningEvent {
  const ResetNavigationEvent();
}
