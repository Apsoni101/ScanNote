import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick an image from the gallery
  Future<Either<Failure, String>> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image == null) {
        return left(const Failure(message: 'Image not selected'));
      }

      return right(image.path);
    } catch (e) {
      return left(_handleException(e));
    }
  }

  /// Pick an image from the camera
  Future<Either<Failure, String>> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image == null) {
        return left(const Failure(message: 'Image not captured'));
      }

      return right(image.path);
    } catch (e) {
      return left(_handleException(e));
    }
  }

  /// Handle exceptions and return appropriate failure messages
  Failure _handleException(final Object exception) {
    if (exception is PlatformException) {
      // Check for camera/gallery permission denied errors
      if (exception.code == 'camera_access_denied' ||
          exception.code == 'photo_access_denied' ||
          exception.code.contains('denied')) {
        return const Failure(message: 'Permission Denied');
      }
    }

    final String exceptionString = exception.toString();

    // Check for permission denied errors in string
    if (exceptionString.contains('Permission denied') ||
        exceptionString.contains('permission') ||
        exceptionString.contains('Permission')) {
      return const Failure(message: 'Permission Denied');
    }

    return Failure(message: exceptionString);
  }
}
