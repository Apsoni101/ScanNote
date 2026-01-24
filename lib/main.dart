import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_widget/home_widget.dart';
import 'package:qr_scanner_practice/core/app_theming/app_dark_theme_colors.dart';
import 'package:qr_scanner_practice/core/app_theming/app_light_theme_colors.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';

import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/localisation/app_localizations.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_key_constants.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_service.dart';
import 'package:qr_scanner_practice/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) {
    await HomeWidget.setAppGroupId(AppConstants.appGroupId);
  }
  await _initializeFirebase();
  await _initializeHive();
  await AppInjector.setUp();

  final HiveService hiveService = AppInjector.getIt<HiveService>();
  await hiveService.init(boxName: HiveKeyConstants.boxName);

  final String? modeName = hiveService.getString(HiveKeyConstants.themeMode);
  final ThemeMode savedTheme = modeName != null
      ? ThemeMode.values.byName(modeName)
      : ThemeMode.system;

  final ThemeController themeController = AppInjector.getIt<ThemeController>();
  await themeController.setTheme(savedTheme);

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
          theme: ThemeData(
            brightness: Brightness.light,
            extensions: <ThemeExtension>[AppLightThemeColors()],
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            extensions: <ThemeExtension>[AppDarkThemeColors()],
          ),
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
