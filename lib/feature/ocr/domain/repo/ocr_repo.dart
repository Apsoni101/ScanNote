import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

abstract class OcrRepository {
  Future<Either<Failure, String>> recognizeTextFromGallery();

  Future<Either<Failure, String>> recognizeTextFromCamera();
}
