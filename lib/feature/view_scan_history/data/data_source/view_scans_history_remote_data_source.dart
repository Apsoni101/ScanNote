import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/network/constants/network_constants.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/network/http_api_client.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/paged_sheets_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/scan_result_model.dart';

abstract class ViewScansHistoryRemoteDataSource {
  Future<Either<Failure, PagedSheetsModel>> getAllSheets({
    final String? pageToken,
    final int? pageSize,
  });

  Future<Either<Failure, List<ScanResultModel>>> getScansFromSheet(
    final String sheetId,
  );
}

class ViewScansHistoryRemoteDataSourceImpl
    implements ViewScansHistoryRemoteDataSource {
  ViewScansHistoryRemoteDataSourceImpl({
    required this.apiClient,
    required this.authService,
  });

  final HttpApiClient apiClient;
  final FirebaseAuthService authService;

  Future<Either<Failure, Options>> _getAuthorizedOptions() async {
    final Either<Failure, String> tokenResult = await authService
        .getGoogleAccessToken();

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
  Future<Either<Failure, PagedSheetsModel>> getAllSheets({
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
        'fields': '${NetworkConstants.sheetFields},nextPageToken',
        'pageSize': pageSize ?? NetworkConstants.pageSize,
        'orderBy': NetworkConstants.orderBy,
      };

      if (pageToken != null && pageToken.isNotEmpty) {
        queryParams['pageToken'] = pageToken;
      }

      return apiClient.request<PagedSheetsModel>(
        url: NetworkConstants.driveBaseUrl,
        method: .get,
        options: options,
        queryParameters: queryParams,
        responseParser: (final Map<String, dynamic> json) {
          return .fromJson(json);
        },
      );
    });
  }

  @override
  Future<Either<Failure, List<ScanResultModel>>> getScansFromSheet(
    final String sheetId,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();

    return authOptions.fold(
      (final Failure failure) async =>
          Left<Failure, List<ScanResultModel>>(failure),
      (final Options options) async => _readScansFromSheet(sheetId, options),
    );
  }

  Future<Either<Failure, List<ScanResultModel>>> _readScansFromSheet(
    final String sheetId,
    final Options options,
  ) async {
    const String sheetRange =
        '${AppConstants.sheetName}!${AppConstants.readRange}';
    final String url =
        '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/$sheetRange';

    return apiClient.request<List<ScanResultModel>>(
      url: url,
      method: .get,
      options: options,
      responseParser: (final Map<String, dynamic> json) {
        final List<dynamic> values = json['values'] ?? <dynamic>[];
        return values
            .map(
              (final dynamic row) =>
                  ScanResultModel.fromSheetRow(List<dynamic>.from(row)),
            )
            .toList();
      },
    );
  }
}
