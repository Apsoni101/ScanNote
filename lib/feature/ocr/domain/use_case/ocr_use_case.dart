import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/repo/ocr_repo.dart';

class OcrUseCase {
  const OcrUseCase({required this.ocrRepository});

  final OcrRepository ocrRepository;

  Future<Either<Failure, String>> callFromGallery() async {
    return ocrRepository.recognizeTextFromGallery();
  }

  Future<Either<Failure, String>> callFromCamera() async {
    return ocrRepository.recognizeTextFromCamera();
  }

  Future<Either<Failure, String>> callFromFile(final File imageFile) async {
    return ocrRepository.recognizeTextFromFile(imageFile);
  }

  Future<Either<Failure, String>> callFromInputImage(final dynamic inputImage) async {
    return ocrRepository.recognizeTextFromInputImage(inputImage);
  }
}