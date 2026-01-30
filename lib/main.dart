import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_scanner_practice/core/app_theming/app_color_theme_extension.dart';
import 'package:qr_scanner_practice/core/app_theming/app_dark_theme_colors.dart';
import 'package:qr_scanner_practice/core/app_theming/app_light_theme_colors.dart';
import 'package:qr_scanner_practice/core/controller/app_settings_controller.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/language_enum.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_key_constants.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_service.dart';
import 'package:qr_scanner_practice/core/localisation/app_localizations.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.dart';
import 'package:qr_scanner_practice/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeFirebase();
  await _initializeHive();
  await AppInjector.setUp();

  final HiveService hiveService = AppInjector.getIt<HiveService>();
  await hiveService.init(boxName: HiveKeyConstants.boxName);

  final String? modeName = hiveService.getString(HiveKeyConstants.themeMode);
  final String? languageName = hiveService.getString(HiveKeyConstants.language);
  final ThemeMode savedTheme = modeName != null
      ? .values.byName(modeName)
      : .system;
  final LanguageEnum savedLanguage = languageName != null
      ? .fromCode(languageName)
      : .english;

  final AppSettingsController appSettingsController =
      AppInjector.getIt<AppSettingsController>()
        ..initialize(themeMode: savedTheme, language: savedLanguage);
  runApp(MyApp(appSettingsController: appSettingsController));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.appSettingsController, super.key});

  final AppSettingsController appSettingsController;

  @override
  Widget build(final BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return ValueListenableBuilder<AppSettings>(
      valueListenable: appSettingsController,
      builder:
          (
            final BuildContext context,
            final (ThemeMode, LanguageEnum) setting,
            _,
          ) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'ScanNote',
              routerConfig: appRouter.config(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,

              ///gets the thememode value from records and give to thememode
              themeMode: setting.$1,

              ///gets the language locale from record and gives t
              locale: setting.$2.locale,

              theme: ThemeData(
                brightness: .light,
                extensions: <ThemeExtension<AppColorThemeExtension>>[
                  AppLightThemeColors(),
                ],
              ),
              darkTheme: ThemeData(
                brightness: .dark,
                extensions: <ThemeExtension<AppColorThemeExtension>>[
                  AppDarkThemeColors(),
                ],
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
