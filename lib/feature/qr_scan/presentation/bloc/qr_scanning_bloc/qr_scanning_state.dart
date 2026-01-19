part of 'qr_scanning_bloc.dart';

class QrScanningState extends Equatable {
  const QrScanningState({
    this.qrDetected,
    this.isLoading = false,
    this.isFlashOn = false,
    this.isProcessingImage = false,
    this.error,
    this.imagePath,
  });

  final String? qrDetected;
  final bool isLoading;
  final bool isFlashOn;
  final bool isProcessingImage;
  final String? error;
  final String? imagePath;

  QrScanningState copyWith({
    final String? qrDetected,
    final bool? isLoading,
    final bool? isFlashOn,
    final bool? isProcessingImage,
    final String? error,
    final String? imagePath,
  }) {
    return QrScanningState(
      qrDetected: qrDetected ?? this.qrDetected,
      isLoading: isLoading ?? this.isLoading,
      isFlashOn: isFlashOn ?? this.isFlashOn,
      isProcessingImage: isProcessingImage ?? this.isProcessingImage,
      error: error ?? this.error,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    qrDetected,
    isLoading,
    isFlashOn,
    isProcessingImage,
    error,
    imagePath,
  ];
}
