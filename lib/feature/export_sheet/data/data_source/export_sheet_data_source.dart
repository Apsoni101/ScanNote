import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/enums/export_format_enum.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/network/constants/network_constants.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/network/http_method.dart';
import 'package:qr_scanner_practice/core/services/download_service.dart';
import 'package:qr_scanner_practice/core/services/permission_service.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/paged_sheets_model.dart';

abstract class ExportSheetDataSource {
  Future<Either<Failure, PagedSheetsModel>> getOwnedSheets({
    final String? pageToken,
    final int? pageSize,
  });

  Future<Either<Failure, String>> downloadSheetFile({
    required final String fileId,
    required final String sheetName,
    required final ExportFormat format,
  });

  void dispose();
}

class ExportSheetDataSourceImpl extends ExportSheetDataSource {
  ExportSheetDataSourceImpl({
    required this.apiClient,
    required this.authService,
    required this.downloadService,
    required this.permissionService,
  });

  final HttpApiClient apiClient;
  final FirebaseAuthService authService;
  final DownloadService downloadService;
  final PermissionService permissionService;

  /// Get Google access token
  Future<Either<Failure, String>> _getAccessToken() async {
    return authService.getGoogleAccessToken();
  }

  /// Get authorized Dio options with Bearer token
  Future<Either<Failure, Options>> _getAuthorizedOptions() async {
    final Either<Failure, String> tokenResult = await _getAccessToken();
    return tokenResult.fold(
      Left.new,
      (final String token) => Right<Failure, Options>(
        Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, PagedSheetsModel>> getOwnedSheets({
    final String? pageToken,
    final int? pageSize,
  }) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();

    return authOptions.fold(Left.new, (final Options options) async {
      const String query =
          'mimeType="${NetworkConstants.sheetMimeType}" '
          'and "me" in owners '
          'and trashed=false '
          'and properties has { '
          'key="appCreated" '
          'and value="${AppConstants.appCreatedLabel}" '
          '}';

      final Map<String, dynamic> queryParams = <String, dynamic>{
        'q': query,
        'fields': '${NetworkConstants.sheetFields}, nextPageToken',
        'pageSize': pageSize ?? NetworkConstants.pageSize,
        'orderBy': NetworkConstants.orderBy,
      };

      if (pageToken != null && pageToken.isNotEmpty) {
        queryParams['pageToken'] = pageToken;
      }

      return apiClient.request<PagedSheetsModel>(
        url: NetworkConstants.driveBaseUrl,
        method: HttpMethod.get,
        options: options,
        queryParameters: queryParams,
        responseParser: (final Map<String, dynamic> json) {
          return PagedSheetsModel.fromJson(json);
        },
      );
    });
  }

  @override
  Future<Either<Failure, String>> downloadSheetFile({
    required final String fileId,
    required final String sheetName,
    required final ExportFormat format,
  }) async {
    final bool hasPermission = await permissionService
        .requestStoragePermission();
    if (!hasPermission) {
      return const Left<Failure, String>(PermissionDeniedFailure());
    }

    final Either<Failure, String> tokenResult = await _getAccessToken();

    return tokenResult.fold(Left.new, (final String token) async {
      final String mime = format.mimeType;

      return downloadService.downloadFile(
        url: '${NetworkConstants.driveBaseUrl}/$fileId/export?mimeType=$mime',
        fileName:
            '${sheetName}_${DateTime.now().millisecondsSinceEpoch}.${format.name}',
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
    });
  }

  @override
  void dispose() {
    downloadService.dispose();
  }
}
