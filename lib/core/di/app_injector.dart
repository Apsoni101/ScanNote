import 'package:get_it/get_it.dart';
import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/navigation/auth_guard.dart';
import 'package:qr_scanner_practice/core/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/services/connectivity_service.dart';
import 'package:qr_scanner_practice/core/services/device_info_service.dart';
import 'package:qr_scanner_practice/core/services/image_picker_service.dart';
import 'package:qr_scanner_practice/core/services/ocr_service.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_service.dart';
import 'package:qr_scanner_practice/feature/auth/data/data_sources/google_sign_in_sign_up_remote_datasource.dart';
import 'package:qr_scanner_practice/feature/auth/data/repositories/google_sign_in_sign_up_remote_repo_impl.dart';
import 'package:qr_scanner_practice/feature/auth/domain/repositories/google_sign_in_sign_up_remote_repo.dart';
import 'package:qr_scanner_practice/feature/auth/domain/use_cases/google_sign_in_sign_up_remote_usecase.dart';
import 'package:qr_scanner_practice/feature/auth/presentation/bloc/google_sign_in_sign_up_bloc/google_sign_in_sign_up_bloc.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_local_data_source.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/home/data/repo_impl/home_screen_repository_impl.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_repository.dart';
import 'package:qr_scanner_practice/feature/home/domain/use_case/home_screen_use_case.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/ocr/data/data_source/ocr_data_source.dart';
import 'package:qr_scanner_practice/feature/ocr/data/repo_impl/ocr_repo_impl.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/repo/ocr_repo.dart';
import 'package:qr_scanner_practice/feature/ocr/domain/use_case/ocr_use_case.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/data_source/scan_result_local_data_source.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/data_source/scan_result_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/repo_impl/scan_result_repository_impl.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/repo/scan_result_repository.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/usecase/scan_result_use_case.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/bloc/result_saving_bloc/result_saving_bloc.dart';
import 'package:qr_scanner_practice/feature/setting/data/data_source/settings_local_data_source.dart';
import 'package:qr_scanner_practice/feature/setting/data/data_source/settings_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/setting/data/repo_impl/settings_repository_impl.dart';
import 'package:qr_scanner_practice/feature/setting/domain/repo/settings_repository.dart';
import 'package:qr_scanner_practice/feature/setting/domain/usecase/settings_usecase.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/bloc/settings_bloc.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/data/data_source/view_scans_history_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/data/repo_impl/view_scans_history_remote_repository_impl.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/repo/view_scans_history_remote_repository.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/usecase/view_scans_history_remote_use_case.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/bloc/view_scans_history_screen_bloc.dart';

class AppInjector {
  AppInjector._();

  static final GetIt getIt = GetIt.instance;

  static Future<void> setUp() async {
    getIt
      /// Core Services
      ..registerSingleton<HiveService>(HiveService())
      ..registerLazySingleton<HttpApiClient>(HttpApiClient.new)
      ..registerLazySingleton<FirebaseAuthService>(FirebaseAuthService.new)
      ..registerLazySingleton<ConnectivityService>(ConnectivityService.new)
      ..registerLazySingleton<DeviceInfoService>(DeviceInfoService.new)
      ..registerLazySingleton<ImagePickerService>(ImagePickerService.new)
      ..registerLazySingleton<OcrService>(OcrService.new)
      ..registerLazySingleton<ThemeController>(ThemeController.new)
      ..registerLazySingleton<AuthGuard>(
        () => AuthGuard(firebaseAuthService: getIt<FirebaseAuthService>()),
      )
      ///DATASOURCE
      ..registerLazySingleton<GoogleSignInSignUpRemoteDataSource>(
        () => GoogleSignInSignUpRemoteDataSourceImpl(
          authService: getIt<FirebaseAuthService>(),
        ),
      )
      ..registerLazySingleton<ScanResultLocalDataSource>(
        () => ScanResultLocalDataSourceImpl(hiveService: getIt<HiveService>()),
      )
      ..registerLazySingleton<HomeScreenLocalDataSource>(
        () => HomeScreenLocalDataSourceImpl(hiveService: getIt<HiveService>()),
      )
      ..registerSingleton<ScanResultRemoteDataSource>(
        ScanResultRemoteDataSourceImpl(
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
      ..registerSingleton<ViewScansHistoryRemoteDataSource>(
        ViewScansHistoryRemoteDataSourceImpl(
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
      ..registerSingleton<SettingsRemoteDataSource>(
        SettingsRemoteDataSourceImpl(
          firebaseAuthService: getIt<FirebaseAuthService>(),
        ),
      )
      ..registerSingleton<SettingsLocalDataSource>(
        SettingsLocalDataSourceImpl(getIt<HiveService>()),
      )
      ///Repo
      ..registerLazySingleton<GoogleSignInSignUpRemoteRepo>(
        () => GoogleSignInSignUpRemoteRepoImpl(
          authRemoteDataSource: getIt<GoogleSignInSignUpRemoteDataSource>(),
        ),
      )
      ..registerSingleton<ScanResultRepository>(
        ScanResultRepositoryImpl(
          remoteDataSource: getIt<ScanResultRemoteDataSource>(),
          localDataSource: getIt<ScanResultLocalDataSource>(),
        ),
      )
      ..registerSingleton<HomeScreenRepository>(
        HomeScreenRepositoryImpl(
          remoteDataSource: getIt<HomeScreenRemoteDataSource>(),
          localDataSource: getIt<HomeScreenLocalDataSource>(),
        ),
      )
      ..registerSingleton<ViewScansHistoryRemoteRepository>(
        ViewScansHistoryRemoteRepositoryImpl(
          remoteDataSource: getIt<ViewScansHistoryRemoteDataSource>(),
        ),
      )
      ..registerSingleton<OcrRepository>(
        OcrRepositoryImpl(ocrDataSource: getIt<OcrDataSource>()),
      )
      ..registerSingleton<SettingsRepository>(
        SettingsRepositoryImpl(
          remoteDataSource: getIt<SettingsRemoteDataSource>(),
          localDataSource: getIt<SettingsLocalDataSource>(),
        ),
      )
      ///USE CASES
      ..registerLazySingleton<GoogleSignInSignUpRemoteUseCase>(
        () => GoogleSignInSignUpRemoteUseCase(
          authRemoteRepo: getIt<GoogleSignInSignUpRemoteRepo>(),
        ),
      )
      ..registerSingleton<ScanResultUseCase>(
        ScanResultUseCase(repository: getIt<ScanResultRepository>()),
      )
      ..registerSingleton<HomeScreenUseCase>(
        HomeScreenUseCase(repository: getIt<HomeScreenRepository>()),
      )
      ..registerSingleton<ViewScansHistoryRemoteUseCase>(
        ViewScansHistoryRemoteUseCase(
          repository: getIt<ViewScansHistoryRemoteRepository>(),
        ),
      )
      ..registerSingleton<OcrUseCase>(
        OcrUseCase(ocrRepository: getIt<OcrRepository>()),
      )
      ..registerSingleton<SettingsUseCase>(
        SettingsUseCase(repository: getIt<SettingsRepository>()),
      )
      ///BLOCS
      ..registerFactory(
        () => GoogleSignInSignUpBloc(
          authRemoteUseCase: getIt<GoogleSignInSignUpRemoteUseCase>(),
        ),
      )
      ..registerFactory(
        () => HomeScreenBloc(
          useCase: getIt<HomeScreenUseCase>(),
          connectivityService: getIt<ConnectivityService>(),
        ),
      )
      ..registerFactory<ViewScansHistoryScreenBloc>(
        () => ViewScansHistoryScreenBloc(
          getScansHistoryUseCase: getIt<ViewScansHistoryRemoteUseCase>(),
        ),
      )
      ..registerFactory<ResultBloc>(ResultBloc.new)
      ..registerFactory<QrScanningBloc>(
        () => QrScanningBloc(imagePickerService: getIt<ImagePickerService>()),
      )
      ..registerFactory<SettingsBloc>(
        () => SettingsBloc(settingsUseCase: getIt<SettingsUseCase>()),
      )
      ..registerFactory<OcrBloc>(() => OcrBloc(ocrUseCase: getIt<OcrUseCase>()))
      ..registerFactory<ResultSavingBloc>(
        () => ResultSavingBloc(useCase: getIt<ScanResultUseCase>()),
      );
  }
}
