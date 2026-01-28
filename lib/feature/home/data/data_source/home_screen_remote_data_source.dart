import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/network/constants/network_constants.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/network/http_method.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/scan_result_model.dart';

abstract class HomeScreenRemoteDataSource {
  Future<Either<Failure, Unit>> saveScan(
    final ScanResultModel model,
    final String sheetId,
  );
  Future<Either<Failure, String>> createSheet(final String sheetName);
}

class HomeScreenRemoteDataSourceImpl implements HomeScreenRemoteDataSource {
  HomeScreenRemoteDataSourceImpl({
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

  Future<Either<Failure, String?>> _getUserId() async {
    final Either<Failure, String> userIdResult = await authService
        .getCurrentUserId();
    return userIdResult.fold(
      (final Failure _) => const Right<Failure, String?>(null),
      Right<Failure, String?>.new,
    );
  }

  @override
  Future<Either<Failure, Unit>> saveScan(
    final ScanResultModel model,
    final String sheetId,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String?> userIdResult = await _getUserId();
      return userIdResult.fold(Left.new, (final String? userId) async {
        final ScanResultModel modelWithUserId = model.copyWith(userId: userId);
        return apiClient.request<Unit>(
          url:
              '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${NetworkConstants.appendRange}',
          method: HttpMethod.post,
          options: options,
          queryParameters: <String, String>{'valueInputOption': 'RAW'},
          data: <String, dynamic>{
            'values': <List<dynamic>>[modelWithUserId.toSheetRow()],
          },
          responseParser: (_) => unit,
        );
      });
    });
  }

  @override
  Future<Either<Failure, String>> createSheet(final String sheetName) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String> spreadsheetId = await apiClient
          .request<String>(
            url: NetworkConstants.sheetsBaseUrl,
            method: HttpMethod.post,
            options: options,
            data: <String, dynamic>{
              'properties': <String, dynamic>{'title': sheetName},
              'sheets': <dynamic>[
                <String, dynamic>{
                  'properties': <String, dynamic>{
                    'sheetId': 0,
                    'title': AppConstants.sheetName,
                  },
                  'data': <dynamic>[
                    <String, dynamic>{
                      'rowData': <dynamic>[
                        <String, dynamic>{
                          'values': <dynamic>[
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerTimestamp,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerQrData,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerComment,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerDeviceId,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerUserId,
                              },
                            },
                          ],
                        },
                      ],
                    },
                  ],
                },
              ],
            },
            responseParser: (final Map<String, dynamic> json) =>
                json['spreadsheetId']?.toString() ?? '',
          );

      return spreadsheetId.fold(Left.new, (final String id) async {
        final Either<Failure, Unit> updateResult = await apiClient
            .request<Unit>(
              url: '${NetworkConstants.driveBaseUrl}/$id',
              method: HttpMethod.patch,
              options: options,
              queryParameters: <String, dynamic>{'fields': 'properties'},
              data: <String, dynamic>{
                'properties': <String, dynamic>{
                  'appCreated': AppConstants.appCreatedLabel,
                },
                'description': 'Created by ${AppConstants.appCreatedLabel}',
              },
              responseParser: (_) => unit,
            );
        return updateResult.fold(Left.new, (_) => Right<Failure, String>(id));
      });
    });
  }
}
