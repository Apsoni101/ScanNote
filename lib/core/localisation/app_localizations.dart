import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localisation/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Qr'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @extractText.
  ///
  /// In en, this message translates to:
  /// **'Extract Text'**
  String get extractText;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your Google account'**
  String get signInWithGoogle;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @qrScanner.
  ///
  /// In en, this message translates to:
  /// **'QR Scanner'**
  String get qrScanner;

  /// No description provided for @qrScanError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while scanning the QR code'**
  String get qrScanError;

  /// No description provided for @noQrCodeFound.
  ///
  /// In en, this message translates to:
  /// **'No QR code found in image'**
  String get noQrCodeFound;

  /// No description provided for @uploadFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from Gallery'**
  String get uploadFromGallery;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// No description provided for @pointCameraToScanQr.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at a QR code to scan'**
  String get pointCameraToScanQr;

  /// Label for the button to view history
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @scannedDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Scanned Data'**
  String get scannedDataTitle;

  /// No description provided for @addCommentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Comment (Optional)'**
  String get addCommentTitle;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your comment or notes...'**
  String get commentHint;

  /// No description provided for @ocrTitle.
  ///
  /// In en, this message translates to:
  /// **'OCR Scanner'**
  String get ocrTitle;

  /// No description provided for @selectImagePrompt.
  ///
  /// In en, this message translates to:
  /// **'Select an image to extract text'**
  String get selectImagePrompt;

  /// No description provided for @extractedText.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text'**
  String get extractedText;

  /// No description provided for @textCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Text copied to clipboard'**
  String get textCopiedToClipboard;

  /// No description provided for @clearButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButtonLabel;

  /// No description provided for @cameraButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraButtonLabel;

  /// No description provided for @galleryButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryButtonLabel;

  /// No description provided for @liveTextRecognition.
  ///
  /// In en, this message translates to:
  /// **'Live Text Recognition'**
  String get liveTextRecognition;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmSave.
  ///
  /// In en, this message translates to:
  /// **'Confirm Save'**
  String get confirmSave;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'QR Data:'**
  String get data;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment:'**
  String get comment;

  /// No description provided for @noCommentAdded.
  ///
  /// In en, this message translates to:
  /// **'(No comment added)'**
  String get noCommentAdded;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @allScansSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'All scans synced successfully!'**
  String get allScansSuccessfullyMessage;

  /// Message shown when syncing scans
  ///
  /// In en, this message translates to:
  /// **'Syncing {count} scan'**
  String syncingMessage(int count);

  /// Message shown when syncing multiple scans
  ///
  /// In en, this message translates to:
  /// **'Syncing {count} scans'**
  String syncingMessagePlural(int count);

  /// No description provided for @confirmAndSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Save'**
  String get confirmAndSaveTitle;

  /// No description provided for @scanDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Details'**
  String get scanDetailsTitle;

  /// No description provided for @selectSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Sheet'**
  String get selectSheetTitle;

  /// No description provided for @newSheetNameTitle.
  ///
  /// In en, this message translates to:
  /// **'New Sheet Name'**
  String get newSheetNameTitle;

  /// No description provided for @sheetNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter sheet name (e.g., \"Scans - Jan 2024\")'**
  String get sheetNameHint;

  /// No description provided for @createSheetButton.
  ///
  /// In en, this message translates to:
  /// **'Create Sheet'**
  String get createSheetButton;

  /// No description provided for @switchToSelectSheet.
  ///
  /// In en, this message translates to:
  /// **'Switch to Select Sheet'**
  String get switchToSelectSheet;

  /// No description provided for @createNewSheet.
  ///
  /// In en, this message translates to:
  /// **'Create New Sheet'**
  String get createNewSheet;

  /// No description provided for @noSheetsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No sheets available. Create a new one!'**
  String get noSheetsAvailable;

  /// No description provided for @scanSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Scan saved successfully!'**
  String get scanSavedSuccessfully;

  /// Shows the modified date of a sheet
  ///
  /// In en, this message translates to:
  /// **'Modified: {date}'**
  String modified(String date);

  /// Title for the history screen
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get scanHistory;

  /// Hint text for search field in history screen
  ///
  /// In en, this message translates to:
  /// **'Search scans...'**
  String get searchScans;

  /// Empty state message when there are no scans
  ///
  /// In en, this message translates to:
  /// **'No scans yet'**
  String get noScansYet;

  /// Empty state message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// Label for the comment field in scan card
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get commentLabel;

  /// Success message after copying QR code
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// Timestamp format for scans from seconds ago
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// Timestamp format for scans from minutes ago
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(int minutes);

  /// Timestamp format for scans from hours ago
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(int hours);

  /// Timestamp format for scans from days ago
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(int days);

  /// Error message when fetching history fails
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch history'**
  String get failedToFetchHistory;

  /// Message shown while refreshing history
  ///
  /// In en, this message translates to:
  /// **'Refreshing...'**
  String get refreshing;

  /// Error message when camera permission is denied
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied'**
  String get cameraPermissionDenied;

  /// Error message when device doesn't support QR scanning
  ///
  /// In en, this message translates to:
  /// **'QR scanning is not supported on this device'**
  String get scanningNotSupported;

  /// Error message when scanner controller is disposed
  ///
  /// In en, this message translates to:
  /// **'Scanner error: Controller disposed'**
  String get scannerControllerDisposed;

  /// Generic scanner error message
  ///
  /// In en, this message translates to:
  /// **'Error: {errorCode}'**
  String scannerError(String errorCode);

  /// No description provided for @qrCodeDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'QR Code Details'**
  String get qrCodeDetailsTitle;

  /// No description provided for @offlineMode.
  ///
  /// In en, this message translates to:
  /// **'Offline Mode'**
  String get offlineMode;

  /// Message shown when offline with pending scans
  ///
  /// In en, this message translates to:
  /// **'{count} scan waiting to sync'**
  String waitingToSyncMessage(int count);

  /// No description provided for @noQrFound.
  ///
  /// In en, this message translates to:
  /// **'No QR code found in image'**
  String get noQrFound;

  /// No description provided for @errorProcessingImage.
  ///
  /// In en, this message translates to:
  /// **'Error processing image'**
  String get errorProcessingImage;

  /// Message shown when offline with multiple pending scans
  ///
  /// In en, this message translates to:
  /// **'{count} scans waiting to sync'**
  String waitingToSyncMessagePlural(int count);

  /// Message shown when ready to sync
  ///
  /// In en, this message translates to:
  /// **'{count} Scan to Sync'**
  String scanToSyncMessage(int count);

  /// Message shown when ready to sync multiple scans
  ///
  /// In en, this message translates to:
  /// **'{count} Scans to Sync'**
  String scanToSyncMessagePlural(int count);

  /// No description provided for @connectionAvailableSync.
  ///
  /// In en, this message translates to:
  /// **'Connection available - click to sync'**
  String get connectionAvailableSync;

  /// No description provided for @syncButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get syncButtonLabel;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Scans will sync when online.'**
  String get noInternetConnection;

  /// No description provided for @cannotRefreshSheets.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Cannot refresh sheets.'**
  String get cannotRefreshSheets;

  /// No description provided for @cameraPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera Permission Required'**
  String get cameraPermissionTitle;

  /// No description provided for @galleryPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Gallery Permission Required'**
  String get galleryPermissionTitle;

  /// No description provided for @permissionRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This app needs permission to access your device. Please grant permission to continue.'**
  String get permissionRequiredMessage;

  /// No description provided for @permissionPermanentlyDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Permission is permanently denied. Please enable it in app settings.'**
  String get permissionPermanentlyDeniedMessage;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @retryButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButtonLabel;

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
