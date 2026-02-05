import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<Either<Failure, Unit>> shareFile(final String filePath) async {
    try {
      await SharePlus.instance.share(
        ShareParams(files: <XFile>[XFile(filePath)]),
      );

      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(Failure(message: e.toString()));
    }
  }
}
