import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';

abstract class OcrRepository {
  Future<Either<Failure, String>> recognizeTextFromGallery();

  Future<Either<Failure, String>> recognizeTextFromCamera();

  Future<Either<Failure, String>> recognizeTextFromFile(File imageFile);

  Future<Either<Failure, String>> recognizeTextFromInputImage(
    final dynamic inputImage,
  );
}
