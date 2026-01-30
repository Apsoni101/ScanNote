// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ScanNote';

  @override
  String get scanExtractSave => 'Scan, Extract, Save';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get pointCameraAtQrCodeToScanInstantly =>
      'Point camera at a QR code to scan instantly';

  @override
  String get pointYourCameraAtAQrCode => 'Point your camera at a QR code ';

  @override
  String get extractTextOcr => 'Extract Text (OCR)';

  @override
  String get extractTextFromImagesOrCamera =>
      'Extract text from images or camera';

  @override
  String get welcome => 'Welcome';

  @override
  String get create => 'Create';

  @override
  String get reviewBeforeSaving => 'Review Before Saving';

  @override
  String get settings => 'Settings';

  @override
  String get noScanHistoryYet => 'No scan history yet';

  @override
  String get yourSavedScansWillAppearHere =>
      'Your saved scans will appear here';

  @override
  String get version1 => 'Version 1.0.0';

  @override
  String get signInToSyncYourScansAcrossDevices =>
      'Sign in to sync your scans across devices';

  @override
  String get signingIn => 'Signing in...';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get newUserSameButtonCreatesYourAccountAutomatically =>
      'New user? The same button creates your account automatically';

  @override
  String get failedToSignInPleaseTryAgain =>
      'Failed to sign in. Please try again.';

  @override
  String get byContinuingYouAgreeToOurTermsOfServiceAndPrivacyPolicy =>
      'By continuing, you agree to our Terms of Service and Privacy Policy';

  @override
  String get appearance => 'APPEARANCE';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get captureImage => 'Capture image';

  @override
  String get uploadImage => 'Upload Image';

  @override
  String get language => 'Language';

  @override
  String get savedTo => 'Saved to : ';

  @override
  String get english => 'English';

  @override
  String get account => 'ACCOUNT';

  @override
  String get errorLoadingUser => 'Error loading user';

  @override
  String get user => 'User';

  @override
  String get noEmail => 'No email';

  @override
  String get signedOut => 'Signed Out';

  @override
  String get youHaveBeenSignedOut => 'You have been signed out';

  @override
  String get about => 'ABOUT';

  @override
  String get logOut => 'Log out';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get extractFromCamera => 'Extract from Camera';

  @override
  String get capturePhotoAndExtractTextInstantly =>
      'Capture a photo and extract text instantly';

  @override
  String get extractFromImage => 'Extract from Image';

  @override
  String get uploadExistingImageToExtractText =>
      'Upload an existing image to extract text';

  @override
  String get extractText => 'Extract Text';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get qrScanError => 'Something went wrong while scanning the QR code';

  @override
  String get noQrCodeFound => 'No QR code found in image';

  @override
  String get uploadFromGallery => 'Upload from Gallery';

  @override
  String get viewHistory => 'View History';

  @override
  String get scannedContent => 'Scanned Content';

  @override
  String get addCommentTitle => 'Add Comment (Optional)';

  @override
  String get addANoteOrDescription => 'Add a note or description...';

  @override
  String get selectGoogleSheet => 'Select Google Sheet';

  @override
  String get saveToSheet => 'Save to Sheet';

  @override
  String get selectImagePrompt => 'Select an image to extract text';

  @override
  String get extractedText => 'Extracted Text';

  @override
  String get textCopiedToClipboard => 'Text copied to clipboard';

  @override
  String get selectSheet => 'Select Sheet';

  @override
  String get cameraButtonLabel => 'Camera';

  @override
  String get galleryButtonLabel => 'Gallery';

  @override
  String get liveTextRecognition => 'Live Text Recognition';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmSave => 'Confirm Save';

  @override
  String get data => 'QR Data:';

  @override
  String get qrResult => 'QR Result';

  @override
  String get comment => 'Comment:';

  @override
  String get noCommentAdded => '(No comment added)';

  @override
  String get confirm => 'Confirm';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get cancel => 'Cancel';

  @override
  String get saveButton => 'Save';

  @override
  String get allScansSuccessfullyMessage => 'All scans synced successfully!';

  @override
  String syncingMessage(int count) {
    return 'Syncing $count scan';
  }

  @override
  String syncingMessagePlural(int count) {
    return 'Syncing $count scans';
  }

  @override
  String get confirmAndSaveTitle => 'Confirm & Save';

  @override
  String get scanDetailsTitle => 'Scan Details';

  @override
  String get selectSheetTitle => 'Select Sheet';

  @override
  String get newSheetNameTitle => 'New Sheet Name';

  @override
  String get enterSheetName => 'Enter sheet name...';

  @override
  String get createSheetButton => 'Create Sheet';

  @override
  String get switchToSelectSheet => 'Switch to Select Sheet';

  @override
  String get createNewSheet => 'Create New Sheet';

  @override
  String get noSheetsAvailable => 'No sheets available. Create a new one!';

  @override
  String get scanSavedSuccessfully => 'Scan saved successfully!';

  @override
  String get savedLocallyWillSyncWhenConnectionIsRestored =>
      'Saved locally. Will sync when connection is restored.';

  @override
  String modified(String date) {
    return 'Modified: $date';
  }

  @override
  String get scanHistory => 'Scan History';

  @override
  String get searchScans => 'Search scans...';

  @override
  String get noScansYet => 'No scans yet';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get commentLabel => 'Comment';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get justNow => 'just now';

  @override
  String minutesAgo(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '${minutesString}m ago';
  }

  @override
  String hoursAgo(int hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return '${hoursString}h ago';
  }

  @override
  String daysAgo(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return '${daysString}d ago';
  }

  @override
  String get failedToFetchHistory => 'Failed to fetch history';

  @override
  String get refreshing => 'Refreshing...';

  @override
  String get cameraPermissionDenied => 'Camera permission denied';

  @override
  String get scanningNotSupported =>
      'QR scanning is not supported on this device';

  @override
  String get scannerControllerDisposed => 'Scanner error: Controller disposed';

  @override
  String scannerError(String errorCode) {
    return 'Error: $errorCode';
  }

  @override
  String get qrCodeDetailsTitle => 'QR Code Details';

  @override
  String get offlineMode => 'Offline Mode';

  @override
  String waitingToSyncMessage(int count) {
    return '$count scan waiting to sync';
  }

  @override
  String get noQrFound => 'No QR code found in image';

  @override
  String get errorProcessingImage => 'Error processing image';

  @override
  String waitingToSyncMessagePlural(int count) {
    return '$count scans waiting to sync';
  }

  @override
  String scanToSyncMessage(int count) {
    return '$count Scan to Sync';
  }

  @override
  String scanToSyncMessagePlural(int count) {
    return '$count Scans to Sync';
  }

  @override
  String get connectionAvailableSync => 'Connection available - click to sync';

  @override
  String get syncButtonLabel => 'Sync';

  @override
  String get noInternetConnection =>
      'No internet connection. Scans will sync when online.';

  @override
  String get cannotRefreshSheets =>
      'No internet connection. Cannot refresh sheets.';

  @override
  String get cameraPermissionTitle => 'Camera Permission Required';

  @override
  String get galleryPermissionTitle => 'Gallery Permission Required';

  @override
  String get permissionRequiredMessage =>
      'This app needs permission to access your device. Please grant permission to continue.';

  @override
  String get permissionPermanentlyDeniedMessage =>
      'Permission is permanently denied. Please enable it in app settings.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get retry => 'Retry';

  @override
  String get loadMore => 'Load More';

  @override
  String get cancelButtonLabel => 'Cancel';
}
