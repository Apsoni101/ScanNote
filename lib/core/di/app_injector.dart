import 'package:get_it/get_it.dart';
import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/navigation/auth_guard.dart';
import 'package:qr_scanner_practice/core/services/connectivity_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/crashlytics_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/firebase_firestore_service.dart';
import 'package:qr_scanner_practice/core/services/network/http_api_client.dart';
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
import 'package:qr_scanner_practice/feature/home/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/data_source/sheets_local_data_source.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/data_source/sheets_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/repo_impl/qr_scan_local_repository_impl.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/repo_impl/qr_scan_remote_repository_impl.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/repo/qr_scan_local_repository.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/repo/qr_scan_remote_repository.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/usecase/qr_result_remote_use_case.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/usecase/qr_scan_local_use_case.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_result_bloc/qr_result_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_result_confirmation_bloc/qr_result_confirmation_bloc.dart';

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
      ..registerLazySingleton(FirebaseFirestoreService.new)
      ..registerLazySingleton(CrashlyticsService.new)
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
      ..registerLazySingleton<SheetsLocalDataSource>(
        () => SheetsLocalDataSourceImpl(hiveService: getIt<HiveService>()),
      )
      ..registerSingleton<SheetsRemoteDataSource>(
        SheetsRemoteDataSourceImpl(
          apiClient: getIt<HttpApiClient>(),
          authService: getIt<FirebaseAuthService>(),
        ),
      )
      ..registerSingleton<HistoryRemoteDataSource>(
        HistoryRemoteDataSourceImpl(
          sheetsRemoteDataSource: getIt<SheetsRemoteDataSource>(),
        ),
      )
      ///Repo
      ..registerLazySingleton<AuthRemoteRepo>(
        () => AuthRemoteRepoImpl(
          authRemoteDataSource: getIt<AuthRemoteDataSource>(),
        ),
      )
      ..registerSingleton<QrScanRemoteRepository>(
        QrScanRemoteRepositoryImpl(
          remoteDataSource: getIt<SheetsRemoteDataSource>(),
        ),
      )
      ..registerLazySingleton<AuthLocalRepo>(
        () => AuthLocalRepoImpl(
          authLocalDataSource: getIt<AuthLocalDataSource>(),
        ),
      )
      ..registerLazySingleton<QrScanLocalRepository>(
        () => QrScanLocalRepositoryImpl(
          localDataSource: getIt<SheetsLocalDataSource>(),
        ),
      )
      ..registerSingleton<HistoryRemoteRepository>(
        HistoryRemoteRepositoryImpl(
          remoteDataSource: getIt<HistoryRemoteDataSource>(),
        ),
      )
      ///USE CASES
      ..registerLazySingleton<AuthRemoteUseCase>(
        () => AuthRemoteUseCase(authRemoteRepo: getIt<AuthRemoteRepo>()),
      )
      ..registerSingleton<QrResultRemoteUseCase>(
        QrResultRemoteUseCase(repository: getIt<QrScanRemoteRepository>()),
      )
      ..registerLazySingleton<AuthLocalUseCase>(
        () => AuthLocalUseCase(authLocalRepo: getIt<AuthLocalRepo>()),
      )
      ..registerLazySingleton<QrScanLocalUseCase>(
        () => QrScanLocalUseCase(repository: getIt<QrScanLocalRepository>()),
      )
      ..registerSingleton<GetHistoryScansUseCase>(
        GetHistoryScansUseCase(repository: getIt<HistoryRemoteRepository>()),
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
          remoteUseCase: getIt<QrResultRemoteUseCase>(),
          localUseCase: getIt<QrScanLocalUseCase>(),
          connectivityService: getIt<ConnectivityService>(),
        ),
      )
      ..registerFactory<HistoryScreenBloc>(()=>
        HistoryScreenBloc(
          getHistoryScansUseCase: getIt<GetHistoryScansUseCase>(),
        ),
      )
      ..registerFactory<QrResultBloc>(QrResultBloc.new)
      ..registerFactory<QrResultConfirmationBloc>(
        () => QrResultConfirmationBloc(
          remoteUseCase: getIt<QrResultRemoteUseCase>(),
          localUseCase: getIt<QrScanLocalUseCase>(),
        ),
      );
  }
}
