import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
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
}
