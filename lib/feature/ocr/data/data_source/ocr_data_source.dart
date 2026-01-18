import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/image_picker_service.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/core/services/ocr_service.dart';

abstract class OcrDataSource {
  Future<Either<Failure, String>> recognizeTextFromGallery();

  Future<Either<Failure, String>> recognizeTextFromCamera();

  Future<Either<Failure, String>> recognizeTextFromFile(final File imageFile);

  Future<Either<Failure, String>> recognizeTextFromInputImage(
    final dynamic inputImage,
  );
}

class OcrDataSourceImpl implements OcrDataSource {
  const OcrDataSourceImpl({
    required this.ocrService,
    required this.imagePickerService,
  });

  final OcrService ocrService;
  final ImagePickerService imagePickerService;

  @override
  Future<Either<Failure, String>> recognizeTextFromGallery() async {
    /// ImagePicker handles permissions internally
    final Either<Failure, String> imagePath = await imagePickerService
        .pickImageFromGallery();

    return imagePath.fold(Left.new, (final String path) async {
      final File imageFile = File(path);
      return ocrService.recognizeText(imageFile);
    });
  }

  @override
  Future<Either<Failure, String>> recognizeTextFromCamera() async {
    /// ImagePicker handles permissions internally
    final Either<Failure, String> imagePath = await imagePickerService
        .pickImageFromCamera();

    return imagePath.fold(Left.new, (final String path) async {
      final File imageFile = File(path);
      return ocrService.recognizeText(imageFile);
    });
  }

  @override
  Future<Either<Failure, String>> recognizeTextFromFile(
    final File imageFile,
  ) async {
    return ocrService.recognizeText(imageFile);
  }

  @override
  Future<Either<Failure, String>> recognizeTextFromInputImage(
    final dynamic inputImage,
  ) async {
    return ocrService.recognizeTextFromInputImage(inputImage);
  }
}
