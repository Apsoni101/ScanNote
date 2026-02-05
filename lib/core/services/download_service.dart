import 'dart:io';
import 'package:background_downloader/background_downloader.dart';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

class DownloadService {
  final FileDownloader _downloader = FileDownloader();

  Future<Either<Failure, String>> downloadFile({
    required final String url,
    required final String fileName,
    required final Map<String, String> headers,
  }) async {
    final Directory dir = Platform.isAndroid
        ? Directory(AppConstants.downloadLocation)
        : await getApplicationDocumentsDirectory();

    final DownloadTask task = DownloadTask(
      url: url,
      filename: fileName,
      directory: dir.path,
      baseDirectory: BaseDirectory.root,
      headers: headers,
    );

    final TaskStatusUpdate result = await _downloader.download(task);

    if (result.status == TaskStatus.complete) {
      return Right<Failure, String>('${dir.path}/$fileName');
    } else {
      return Left<Failure, String>(
        Failure(message: result.exception?.toString() ?? 'Download failed'),
      );
    }
  }

  void dispose() {
    _downloader.destroy();
  }
}
