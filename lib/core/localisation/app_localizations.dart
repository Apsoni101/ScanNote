import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ScanNote'**
  String get appName;

  /// No description provided for @scanExtractSave.
  ///
  /// In en, this message translates to:
  /// **'Scan, Extract, Save'**
  String get scanExtractSave;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// No description provided for @pointCameraAtQrCodeToScanInstantly.
  ///
  /// In en, this message translates to:
  /// **'Point camera at a QR code to scan instantly'**
  String get pointCameraAtQrCodeToScanInstantly;

  /// No description provided for @pointYourCameraAtAQrCode.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at a QR code '**
  String get pointYourCameraAtAQrCode;

  /// No description provided for @extractTextOcr.
  ///
  /// In en, this message translates to:
  /// **'Extract Text (OCR)'**
  String get extractTextOcr;

  /// No description provided for @extractTextFromImagesOrCamera.
  ///
  /// In en, this message translates to:
  /// **'Extract text from images or camera'**
  String get extractTextFromImagesOrCamera;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @reviewBeforeSaving.
  ///
  /// In en, this message translates to:
  /// **'Review Before Saving'**
  String get reviewBeforeSaving;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @noScanHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No scan history yet'**
  String get noScanHistoryYet;

  /// No description provided for @yourSavedScansWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your saved scans will appear here'**
  String get yourSavedScansWillAppearHere;

  /// No description provided for @version1.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version1;

  /// No description provided for @signInToSyncYourScansAcrossDevices.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your scans across devices'**
  String get signInToSyncYourScansAcrossDevices;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @newUserSameButtonCreatesYourAccountAutomatically.
  ///
  /// In en, this message translates to:
  /// **'New user? The same button creates your account automatically'**
  String get newUserSameButtonCreatesYourAccountAutomatically;

  /// No description provided for @failedToSignInPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign in. Please try again.'**
  String get failedToSignInPleaseTryAgain;

  /// No description provided for @byContinuingYouAgreeToOurTermsOfServiceAndPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms of Service and Privacy Policy'**
  String get byContinuingYouAgreeToOurTermsOfServiceAndPrivacyPolicy;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @captureImage.
  ///
  /// In en, this message translates to:
  /// **'Capture image'**
  String get captureImage;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @savedTo.
  ///
  /// In en, this message translates to:
  /// **'Saved to : '**
  String get savedTo;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// No description provided for @errorLoadingUser.
  ///
  /// In en, this message translates to:
  /// **'Error loading user'**
  String get errorLoadingUser;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get noEmail;

  /// No description provided for @signedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed Out'**
  String get signedOut;

  /// No description provided for @youHaveBeenSignedOut.
  ///
  /// In en, this message translates to:
  /// **'You have been signed out'**
  String get youHaveBeenSignedOut;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get about;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @extractFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Extract from Camera'**
  String get extractFromCamera;

  /// No description provided for @capturePhotoAndExtractTextInstantly.
  ///
  /// In en, this message translates to:
  /// **'Capture a photo and extract text instantly'**
  String get capturePhotoAndExtractTextInstantly;

  /// No description provided for @extractFromImage.
  ///
  /// In en, this message translates to:
  /// **'Extract from Image'**
  String get extractFromImage;

  /// No description provided for @uploadExistingImageToExtractText.
  ///
  /// In en, this message translates to:
  /// **'Upload an existing image to extract text'**
  String get uploadExistingImageToExtractText;

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

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

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

  /// Label for the button to view history
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @scannedContent.
  ///
  /// In en, this message translates to:
  /// **'Scanned Content'**
  String get scannedContent;

  /// No description provided for @addCommentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Comment (Optional)'**
  String get addCommentTitle;

  /// No description provided for @addANoteOrDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a note or description...'**
  String get addANoteOrDescription;

  /// No description provided for @selectGoogleSheet.
  ///
  /// In en, this message translates to:
  /// **'Select Google Sheet'**
  String get selectGoogleSheet;

  /// No description provided for @saveToSheet.
  ///
  /// In en, this message translates to:
  /// **'Save to Sheet'**
  String get saveToSheet;

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

  /// No description provided for @selectSheet.
  ///
  /// In en, this message translates to:
  /// **'Select Sheet'**
  String get selectSheet;

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

  /// No description provided for @qrResult.
  ///
  /// In en, this message translates to:
  /// **'QR Result'**
  String get qrResult;

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

  /// No description provided for @enterSheetName.
  ///
  /// In en, this message translates to:
  /// **'Enter sheet name...'**
  String get enterSheetName;

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

  /// No description provided for @savedLocallyWillSyncWhenConnectionIsRestored.
  ///
  /// In en, this message translates to:
  /// **'Saved locally. Will sync when connection is restored.'**
  String get savedLocallyWillSyncWhenConnectionIsRestored;

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

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

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
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
