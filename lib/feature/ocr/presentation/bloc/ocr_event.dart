part of 'ocr_bloc.dart';

@immutable
sealed class OcrEvent extends Equatable {
  const OcrEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickImageFromCameraEvent extends OcrEvent {
  const PickImageFromCameraEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickImageFromGalleryEvent extends OcrEvent {
  const PickImageFromGalleryEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ProcessInputImageEvent extends OcrEvent {
  const ProcessInputImageEvent({required this.inputImage});

  final dynamic inputImage;

  @override
  List<Object?> get props => <Object?>[inputImage];
}

class ClearOcrResultEvent extends OcrEvent {
  const ClearOcrResultEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class RetryPermissionEvent extends OcrEvent {
  const RetryPermissionEvent({required this.permissionType});

  final String permissionType; // 'camera' or 'gallery'

  @override
  List<Object?> get props => <Object?>[permissionType];
}
