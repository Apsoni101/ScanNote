import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

class OcrService {
  OcrService() : _textRecognizer = TextRecognizer();

  final TextRecognizer _textRecognizer;

  Future<Either<Failure, String>> recognizeText(final File imageFile) async {
    try {
      final InputImage inputImage = .fromFile(imageFile);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      return Right<Failure, String>(recognizedText.text);
    } catch (e) {
      return Left<Failure, String>(
        Failure(message: 'Failed to recognize text', data: e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> recognizeTextFromInputImage(
    final InputImage inputImage,
  ) async {
    try {
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      return Right<Failure, String>(recognizedText.text);
    } catch (e) {
      return Left<Failure, String>(
        Failure(
          message: 'Failed to recognize text from camera',
          data: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, void>> dispose() async {
    try {
      await _textRecognizer.close();
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(
        Failure(message: 'Failed to dispose OCR service', data: e.toString()),
      );
    }
  }
}
