import 'package:get_it/get_it.dart';
import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/navigation/auth_guard.dart';
import 'package:qr_scanner_practice/core/services/connectivity_service.dart';
import 'package:qr_scanner_practice/core/services/device_info_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/crashlytics_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/firebase_firestore_service.dart';
import 'package:qr_scanner_practice/core/services/image_picker_service.dart';
import 'package:qr_scanner_practice/core/services/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/services/ocr_service.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_service.dart';
import 'package:qr_scanner_practice/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:qr_scanner_practice/feature/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:qr_scanner_practice/feature/auth/data/repositories/auth_local_repo_impl.dart';
import 'package:qr_scanner_practice/feature/auth/data/repositories/auth_remote_repo_impl.dart';
import 'package:qr_scanner_practice/feature/auth/domain/repositories/auth_local_repo.dart';
import 'package:qr_scanner_practice/feature/auth/domain/repositories/auth_remote_repo.dart';
import 'package:qr_scanner_practice/feature/auth/domain/use_cases/auth_local_usecase.dart';
import 'package:qr_scanner_practice/feature/auth/domain/use_cases/auth_remote_usecase.dart';
import 'package:qr_scanner_practice/feature/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:qr_scanner_practice/feature/history/data/data_source/history_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/history/data/repo_impl/history_remote_repository_impl.dart';
import 'package:qr_scanner_practice/feature/history/domain/repo/history_remote_repository.dart';
import 'package:qr_scanner_practice/feature/history/domain/usecase/get_history_scans_use_case.dart';
import 'package:qr_scanner_practice/feature/history/presentation/bloc/history_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_local_data_source.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/home/data/repo_impl/home_screen_local_repository_impl.dart';
import 'package:qr_scanner_practice/feature/home/data/repo_impl/home_screen_remote_repository_impl.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_local_repository.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_remote_repository.dart';
import 'package:qr_scanner_practice/feature/home/domain/use_case/home_screen_local_use_case.dart';
import 'package:qr_scanner_practice/feature/home/domain/use_case/home_screen_remote_use_case.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/ocr/data/data_source/ocr_data_source.dart';
import 'package:qr_scanner_practice/feature/ocr/data/repo_impl/ocr_repo_impl.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/repo/ocr_repo.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/use_case/ocr_use_case.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/data_source/result_scan_local_data_source.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/data_source/result_scan_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/repo_impl/result_scan_local_repository_impl.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/repo_impl/result_scan_remote_repository_impl.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/repo/result_scan_local_repository.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/repo/result_scan_remote_repository.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/usecase/result_scan_local_use_case.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/usecase/result_scan_remote_use_case.dart';
import 'package:qr_scanner_practice/feature/result_scan/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:qr_scanner_practice/feature/result_scan/presentation/bloc/result_confirmation_bloc/result_confirmation_bloc.dart';

class AppInjector {
  AppInjector._();

  static final GetIt getIt = GetIt.instance;

  static Future<void> setUp() async {
    getIt
      /// Core Services
      ..registerSingleton<HiveService>(HiveService())
      ..registerLazySingleton<HttpApiClient>(HttpApiClient.new)
      ..registerLazySingleton(FirebaseAuthService.new)
      ..registerLazySingleton(ConnectivityService.new)
      ..registerLazySingleton(DeviceInfoService.new)
      ..registerLazySingleton(FirebaseFirestoreService.new)
      ..registerLazySingleton(CrashlyticsService.new)
      ..registerLazySingleton(ImagePickerService.new)
      ..registerLazySingleton(OcrService.new)
      ..registerLazySingleton<ThemeController>(
        () => ThemeController(getIt<HiveService>()),
      )
      ..registerLazySingleton<AuthGuard>(
        () => AuthGuard(firebaseAuthService: getIt<FirebaseAuthService>()),
      )
      ///DATASOURCE
      ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
          authService: getIt<FirebaseAuthService>(),
          firestoreService: getIt<FirebaseFirestoreService>(),
        ),
      )
      ..registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(getIt<HiveService>()),
      )
      ..registerLazySingleton<ResultScanLocalDataSource>(
        () => ResultScanLocalDataSourceImpl(hiveService: getIt<HiveService>()),
      )
      ..registerLazySingleton<HomeScreenLocalDataSource>(
        () => HomeScreenLocalDataSourceImpl(hiveService: getIt<HiveService>()),
      )
      ..registerSingleton<ResultScanRemoteDataSource>(
        ResultScanRemoteDataSourceImpl(
          apiClient: getIt<HttpApiClient>(),
          authService: getIt<FirebaseAuthService>(),
          deviceInfoService: getIt<DeviceInfoService>(),
        ),
      )
      ..registerSingleton<HomeScreenRemoteDataSource>(
        HomeScreenRemoteDataSourceImpl(
          apiClient: getIt<HttpApiClient>(),
          authService: getIt<FirebaseAuthService>(),
        ),
      )
      ..registerSingleton<HistoryRemoteDataSource>(
        HistoryRemoteDataSourceImpl(
          apiClient: getIt<HttpApiClient>(),
          authService: getIt<FirebaseAuthService>(),
        ),
      )
      ..registerSingleton<OcrDataSource>(
        OcrDataSourceImpl(
          ocrService: getIt<OcrService>(),
          imagePickerService: getIt<ImagePickerService>(),
        ),
      )
      ///Repo
      ..registerLazySingleton<AuthRemoteRepo>(
        () => AuthRemoteRepoImpl(
          authRemoteDataSource: getIt<AuthRemoteDataSource>(),
        ),
      )
      ..registerSingleton<ResultScanRemoteRepository>(
        ResultScanRemoteRepositoryImpl(
          remoteDataSource: getIt<ResultScanRemoteDataSource>(),
        ),
      )
      ..registerSingleton<HomeScreenRemoteRepository>(
        HomeScreenRemoteRepositoryImpl(
          remoteDataSource: getIt<HomeScreenRemoteDataSource>(),
        ),
      )
      ..registerLazySingleton<AuthLocalRepo>(
        () => AuthLocalRepoImpl(
          authLocalDataSource: getIt<AuthLocalDataSource>(),
        ),
      )
      ..registerLazySingleton<ResultScanLocalRepository>(
        () => ResultScanLocalRepositoryImpl(
          localDataSource: getIt<ResultScanLocalDataSource>(),
        ),
      )
      ..registerLazySingleton<HomeScreenLocalRepository>(
        () => HomeScreenLocalRepositoryImpl(
          localDataSource: getIt<HomeScreenLocalDataSource>(),
        ),
      )
      ..registerSingleton<HistoryRemoteRepository>(
        HistoryRemoteRepositoryImpl(
          remoteDataSource: getIt<HistoryRemoteDataSource>(),
        ),
      )
      ..registerSingleton<OcrRepository>(
        OcrRepositoryImpl(
          ocrDataSource: getIt<OcrDataSource>(),
        ),
      )
      ///USE CASES
      ..registerLazySingleton<AuthRemoteUseCase>(
        () => AuthRemoteUseCase(authRemoteRepo: getIt<AuthRemoteRepo>()),
      )
      ..registerSingleton<ResultScanRemoteUseCase>(
        ResultScanRemoteUseCase(repository: getIt<ResultScanRemoteRepository>()),
      )
      ..registerSingleton<HomeScreenRemoteUseCase>(
        HomeScreenRemoteUseCase(
          repository: getIt<HomeScreenRemoteRepository>(),
        ),
      )
      ..registerLazySingleton<AuthLocalUseCase>(
        () => AuthLocalUseCase(authLocalRepo: getIt<AuthLocalRepo>()),
      )
      ..registerLazySingleton<ResultScanLocalUseCase>(
        () => ResultScanLocalUseCase(repository: getIt<ResultScanLocalRepository>()),
      )
      ..registerLazySingleton<HomeScreenLocalUseCase>(
        () => HomeScreenLocalUseCase(
          repository: getIt<HomeScreenLocalRepository>(),
        ),
      )
      ..registerSingleton<GetHistoryScansUseCase>(
        GetHistoryScansUseCase(repository: getIt<HistoryRemoteRepository>()),
      )
      ..registerSingleton<OcrUseCase>(
        OcrUseCase(ocrRepository: getIt<OcrRepository>()),
      )
      ///BLOCS
      ..registerFactory(
        () => LoginBloc(
          authRemoteUseCase: getIt<AuthRemoteUseCase>(),
          authLocalUseCase: getIt<AuthLocalUseCase>(),
        ),
      )
      ..registerFactory(
        () => HomeScreenBloc(
          remoteUseCase: getIt<HomeScreenRemoteUseCase>(),
          localUseCase: getIt<HomeScreenLocalUseCase>(),
          connectivityService: getIt<ConnectivityService>(),
        ),
      )
      ..registerFactory<HistoryScreenBloc>(
        () => HistoryScreenBloc(
          getHistoryScansUseCase: getIt<GetHistoryScansUseCase>(),
        ),
      )
      ..registerFactory<ResultBloc>(ResultBloc.new)
      ..registerFactory<ResultScanningBloc>(
        () => ResultScanningBloc(imagePickerService: getIt<ImagePickerService>()),
      )
      ..registerFactory<OcrBloc>(
        () => OcrBloc(ocrUseCase: getIt<OcrUseCase>()),
      )
      ..registerFactory<ResultConfirmationBloc>(
        () => ResultConfirmationBloc(
          remoteUseCase: getIt<ResultScanRemoteUseCase>(),
          localUseCase: getIt<ResultScanLocalUseCase>(),
        ),
      );
  }
}
