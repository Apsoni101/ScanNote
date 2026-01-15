// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Qr';

  @override
  String get home => 'Home';

  @override
  String get analytics => 'Analytics';

  @override
  String get groups => 'Groups';

  @override
  String get wallet => 'Wallet';

  @override
  String get profile => 'Your Profile';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signIn => 'Sign In';

  @override
  String get apple => 'Apple';

  @override
  String get google => 'Google';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInWithGoogle => 'Sign in with your Google account';

  @override
  String get signingIn => 'Signing in...';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get qrScanner => 'QR Scanner';

  @override
  String get qrScanError => 'Something went wrong while scanning the QR code';

  @override
  String get noQrCodeFound => 'No QR code found in image';

  @override
  String get uploadFromGallery => 'Upload from Gallery';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get pointCameraToScanQr => 'Point your camera at a QR code to scan';

  @override
  String get viewHistory => 'View History';

  @override
  String get scannedDataTitle => 'Scanned Data';

  @override
  String get addCommentTitle => 'Add Comment (Optional)';

  @override
  String get commentHint => 'Enter your comment or notes...';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmSave => 'Confirm Save';

  @override
  String get qrData => 'QR Data:';

  @override
  String get comment => 'Comment:';

  @override
  String get noCommentAdded => '(No comment added)';

  @override
  String get confirm => 'Confirm';

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
  String get sheetNameHint => 'Enter sheet name (e.g., \"Scans - Jan 2024\")';

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
}
