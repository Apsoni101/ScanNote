// lib/core/services/text_recognition/text_recognition_service.dart
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionService {
  TextRecognitionService({final TextRecognizer? textRecognizer})
    : _textRecognizer = textRecognizer ?? TextRecognizer();

  final TextRecognizer _textRecognizer;

  /// Process image and extract text
  Future<String?> recognizeText(final InputImage inputImage) async {
    try {
      debugPrint('🔍 [TextRecognitionService] Processing image for text...');
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      final String text = recognizedText.text;
      debugPrint(
        '✅ [TextRecognitionService] Text recognized: ${text.length} characters',
      );
      return text.isNotEmpty ? text : null;
    } catch (e) {
      debugPrint('❌ [TextRecognitionService] Error recognizing text: $e');
      return null;
    }
  }

  /// Process image and get detailed text blocks
  Future<List<TextBlock>?> recognizeTextBlocks(
    final InputImage inputImage,
  ) async {
    try {
      debugPrint(
        '🔍 [TextRecognitionService] Processing image for text blocks...',
      );
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      final List<TextBlock> blocks = recognizedText.blocks;
      debugPrint(
        '✅ [TextRecognitionService] Found ${blocks.length} text blocks',
      );
      return blocks.isNotEmpty ? blocks : null;
    } catch (e) {
      debugPrint(
        '❌ [TextRecognitionService] Error recognizing text blocks: $e',
      );
      return null;
    }
  }

  /// Get recognized text with bounding box information
  Future<RecognizedText?> getDetailedRecognition(
    final InputImage inputImage,
  ) async {
    try {
      debugPrint(
        '🔍 [TextRecognitionService] Getting detailed text recognition...',
      );
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      debugPrint(
        '✅ [TextRecognitionService] Recognition complete with ${recognizedText.blocks.length} blocks',
      );
      return recognizedText;
    } catch (e) {
      debugPrint(
        '❌ [TextRecognitionService] Error in detailed recognition: $e',
      );
      return null;
    }
  }

  /// Close the text recognizer and free up resources
  Future<void> dispose() async {
    try {
      await _textRecognizer.close();
      debugPrint('🔒 [TextRecognitionService] Text recognizer closed');
    } catch (e) {
      debugPrint(
        '❌ [TextRecognitionService] Error closing text recognizer: $e',
      );
    }
  }
}
