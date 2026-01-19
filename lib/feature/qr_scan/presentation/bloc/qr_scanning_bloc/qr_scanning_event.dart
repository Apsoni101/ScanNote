part of 'qr_scanning_bloc.dart';

sealed class QrScanningEvent extends Equatable {
  const QrScanningEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class QrDetectedEvent extends QrScanningEvent {
  const QrDetectedEvent(this.code);

  final String code;

  @override
  List<Object?> get props => <Object?>[code];
}

class ToggleFlashEvent extends QrScanningEvent {
  const ToggleFlashEvent();
}

class ScanQrFromGalleryEvent extends QrScanningEvent {
  const ScanQrFromGalleryEvent();
}

class ScanQrFromCameraEvent extends QrScanningEvent {
  const ScanQrFromCameraEvent();
}

class ResetNavigationEvent extends QrScanningEvent {
  const ResetNavigationEvent();
}
