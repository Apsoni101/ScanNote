import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/ocr/data/data_source/ocr_data_source.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/repo/ocr_repo.dart';

class OcrRepositoryImpl implements OcrRepository {
  const OcrRepositoryImpl({required this.ocrDataSource});

  final OcrDataSource ocrDataSource;

  @override
  Future<Either<Failure, String>> recognizeTextFromGallery() async {
    return ocrDataSource.recognizeTextFromGallery();
  }

  @override
  Future<Either<Failure, String>> recognizeTextFromCamera() async {
    return ocrDataSource.recognizeTextFromCamera();
  }

  @override
  Future<Either<Failure, String>> recognizeTextFromFile(
    final File imageFile,
  ) async {
    return ocrDataSource.recognizeTextFromFile(imageFile);
  }

  @override
  Future<Either<Failure, String>> recognizeTextFromInputImage(
    final dynamic inputImage,
  ) async {
    return ocrDataSource.recognizeTextFromInputImage(inputImage);
  }
}
