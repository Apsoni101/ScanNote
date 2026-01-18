part of 'qr_scanning_bloc.dart';

class ResultScanningState extends Equatable {
  const ResultScanningState({
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

  ResultScanningState copyWith({
    final String? qrDetected,
    final bool? isLoading,
    final bool? isFlashOn,
    final bool? isProcessingImage,
    final String? error,
    final String? imagePath,
  }) {
    return ResultScanningState(
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
