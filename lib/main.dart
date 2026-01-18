import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/localisation/app_localizations.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_service.dart';
import 'package:qr_scanner_practice/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeFirebase();

  await _initializeHive();

  await AppInjector.setUp();
  await AppInjector.getIt<HiveService>().init(boxName: 'userBox');

  final ThemeController themeController = AppInjector.getIt<ThemeController>();

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  Widget build(final BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (final BuildContext context, final ThemeMode themeMode, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'CodiScan',
          routerConfig: appRouter.config(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: themeMode,
          theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
          darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        );
      },
    );
  }
}

/// 🔥 Firebase Initialization
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized');
  } catch (e) {
    debugPrint('⚠️ Firebase init failed: $e');
    // App can still run without Firebase
  }
}

Future<void> _initializeHive() async {
  try {
    await Hive.initFlutter();
    HiveService.registerAdapters();
  } catch (e) {
    rethrow;
  }
}
