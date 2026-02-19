import 'package:flutter/material.dart';

/// replaced hex code names  and inconsistent names of colors and followed a unified approach to avoid anomaly caused of names of colors
/// when color changes in dark mode or any theme mode causing code to be less scalable and readable .

class AppColorThemeExtension extends ThemeExtension<AppColorThemeExtension> {
  AppColorThemeExtension({
    required this.primaryDefault,
    required this.primaryPressed,
    required this.primaryDisabled,
    required this.secondaryDefaultTextBorder,
    required this.secondaryPressedTextBorder,
    required this.secondaryPressedBackground,
    required this.secondaryDisabledTextBorder,
    required this.accentDefault,
    required this.accentPressed,
    required this.semanticsTextError,
    required this.semanticsIconError,
    required this.semanticsTextSuccess,
    required this.semanticsIconSuccess,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInversePrimary,
    required this.textInverseSecondary,
    required this.surfaceL1,
    required this.surfaceL2,
    required this.surfaceL3,
    required this.separator,
    required this.borderInputDefault,
    required this.borderInputFocused,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconTertiary,
    required this.scanFrameCorner,
    required this.scanLineGradient,
    required this.cameraOverlay,
    required this.flashActive,
    required this.sheetCardSelected,
    required this.qrBadgeBackground,
    required this.qrBadgeText,
    required this.ocrBadgeBackground,
    required this.ocrBadgeText,
    required this.scaffoldBackground,
    required this.appBarBackground,
    required this.buttonPrimaryBackground,
    required this.buttonSecondaryBackground,
    required this.bottomNavBackground,
    required this.cardBackground,
    required this.dialogBackground,
    required this.snackbarBackground,
    required this.splashBackground,
    required this.splashLogoTint,
    required this.splashText,
    required this.splashIndicator,
    required this.switchActiveTrack,
    required this.switchActiveThumb,
    required this.switchInactiveTrack,
    required this.switchInactiveThumb,
    required this.pdfIconBackground,
    required this.excelIconBackground,
    required this.csvIconBackground,
    required this.pdfTextBackground,
    required this.excelTextBackground,
    required this.csvTextBackground,
    required this.scannerBackground,
  });

  final Color primaryDefault;
  final Color primaryPressed;
  final Color primaryDisabled;
  final Color secondaryDefaultTextBorder;
  final Color secondaryPressedTextBorder;
  final Color secondaryPressedBackground;
  final Color secondaryDisabledTextBorder;
  final Color accentDefault;
  final Color accentPressed;
  final Color semanticsTextError;
  final Color semanticsIconError;
  final Color semanticsTextSuccess;
  final Color semanticsIconSuccess;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInversePrimary;
  final Color textInverseSecondary;
  final Color surfaceL1;
  final Color surfaceL2;
  final Color surfaceL3;
  final Color separator;
  final Color borderInputDefault;
  final Color borderInputFocused;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconTertiary;
  final Color scanFrameCorner;
  final Color scanLineGradient;
  final Color cameraOverlay;
  final Color flashActive;
  final Color sheetCardSelected;
  final Color qrBadgeBackground;
  final Color qrBadgeText;
  final Color ocrBadgeBackground;
  final Color ocrBadgeText;
  final Color scaffoldBackground;
  final Color appBarBackground;
  final Color buttonPrimaryBackground;
  final Color buttonSecondaryBackground;
  final Color bottomNavBackground;
  final Color cardBackground;
  final Color dialogBackground;
  final Color snackbarBackground;
  final Color splashBackground;
  final Color splashLogoTint;
  final Color splashText;
  final Color splashIndicator;
  final Color switchActiveTrack;
  final Color switchActiveThumb;
  final Color switchInactiveTrack;
  final Color switchInactiveThumb;
  final Color pdfIconBackground;
  final Color excelIconBackground;
  final Color csvIconBackground;
  final Color pdfTextBackground;
  final Color excelTextBackground;
  final Color csvTextBackground;
  final Color scannerBackground;

  @override
  ThemeExtension<AppColorThemeExtension> copyWith({
    final Color? primaryDefault,
    final Color? primaryPressed,
    final Color? primaryDisabled,
    final Color? secondaryDefaultTextBorder,
    final Color? secondaryPressedTextBorder,
    final Color? secondaryPressedBackground,
    final Color? secondaryDisabledTextBorder,
    final Color? accentDefault,
    final Color? accentPressed,
    final Color? semanticsTextError,
    final Color? semanticsIconError,
    final Color? semanticsTextSuccess,
    final Color? semanticsIconSuccess,
    final Color? textPrimary,
    final Color? textSecondary,
    final Color? textTertiary,
    final Color? textDisabled,
    final Color? textInversePrimary,
    final Color? textInverseSecondary,
    final Color? surfaceL1,
    final Color? surfaceL2,
    final Color? surfaceL3,
    final Color? separator,
    final Color? borderInputDefault,
    final Color? borderInputFocused,
    final Color? iconPrimary,
    final Color? iconSecondary,
    final Color? iconTertiary,
    final Color? scanFrameCorner,
    final Color? scanLineGradient,
    final Color? cameraOverlay,
    final Color? flashActive,
    final Color? sheetCardSelected,
    final Color? qrBadgeBackground,
    final Color? qrBadgeText,
    final Color? ocrBadgeBackground,
    final Color? ocrBadgeText,
    final Color? scaffoldBackground,
    final Color? appBarBackground,
    final Color? buttonPrimaryBackground,
    final Color? buttonSecondaryBackground,
    final Color? bottomNavBackground,
    final Color? cardBackground,
    final Color? dialogBackground,
    final Color? snackbarBackground,
    final Color? splashBackground,
    final Color? splashLogoTint,
    final Color? splashText,
    final Color? splashIndicator,
    final Color? switchActiveTrack,
    final Color? switchActiveThumb,
    final Color? switchInactiveTrack,
    final Color? switchInactiveThumb,
    final Color? pdfIconBackground,
    final Color? excelIconBackground,
    final Color? csvIconBackground,
    final Color? pdfTextBackground,
    final Color? excelTextBackground,
    final Color? csvTextBackground,
    final Color? scannerBackground,
  }) {
    return AppColorThemeExtension(
      primaryDefault: primaryDefault ?? this.primaryDefault,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      primaryDisabled: primaryDisabled ?? this.primaryDisabled,
      secondaryDefaultTextBorder:
          secondaryDefaultTextBorder ?? this.secondaryDefaultTextBorder,
      secondaryPressedTextBorder:
          secondaryPressedTextBorder ?? this.secondaryPressedTextBorder,
      secondaryPressedBackground:
          secondaryPressedBackground ?? this.secondaryPressedBackground,
      secondaryDisabledTextBorder:
          secondaryDisabledTextBorder ?? this.secondaryDisabledTextBorder,
      accentDefault: accentDefault ?? this.accentDefault,
      accentPressed: accentPressed ?? this.accentPressed,
      semanticsTextError: semanticsTextError ?? this.semanticsTextError,
      semanticsIconError: semanticsIconError ?? this.semanticsIconError,
      semanticsTextSuccess: semanticsTextSuccess ?? this.semanticsTextSuccess,
      semanticsIconSuccess: semanticsIconSuccess ?? this.semanticsIconSuccess,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      textInversePrimary: textInversePrimary ?? this.textInversePrimary,
      textInverseSecondary: textInverseSecondary ?? this.textInverseSecondary,
      surfaceL1: surfaceL1 ?? this.surfaceL1,
      surfaceL2: surfaceL2 ?? this.surfaceL2,
      surfaceL3: surfaceL3 ?? this.surfaceL3,
      separator: separator ?? this.separator,
      borderInputDefault: borderInputDefault ?? this.borderInputDefault,
      borderInputFocused: borderInputFocused ?? this.borderInputFocused,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      iconTertiary: iconTertiary ?? this.iconTertiary,
      scanFrameCorner: scanFrameCorner ?? this.scanFrameCorner,
      scanLineGradient: scanLineGradient ?? this.scanLineGradient,
      cameraOverlay: cameraOverlay ?? this.cameraOverlay,
      flashActive: flashActive ?? this.flashActive,
      sheetCardSelected: sheetCardSelected ?? this.sheetCardSelected,
      qrBadgeBackground: qrBadgeBackground ?? this.qrBadgeBackground,
      qrBadgeText: qrBadgeText ?? this.qrBadgeText,
      ocrBadgeBackground: ocrBadgeBackground ?? this.ocrBadgeBackground,
      ocrBadgeText: ocrBadgeText ?? this.ocrBadgeText,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      appBarBackground: appBarBackground ?? this.appBarBackground,
      buttonPrimaryBackground:
          buttonPrimaryBackground ?? this.buttonPrimaryBackground,
      buttonSecondaryBackground:
          buttonSecondaryBackground ?? this.buttonSecondaryBackground,
      bottomNavBackground: bottomNavBackground ?? this.bottomNavBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      snackbarBackground: snackbarBackground ?? this.snackbarBackground,
      splashBackground: splashBackground ?? this.splashBackground,
      splashLogoTint: splashLogoTint ?? this.splashLogoTint,
      splashText: splashText ?? this.splashText,
      splashIndicator: splashIndicator ?? this.splashIndicator,
      switchActiveTrack: switchActiveTrack ?? this.switchActiveTrack,
      switchActiveThumb: switchActiveThumb ?? this.switchActiveThumb,
      switchInactiveTrack: switchInactiveTrack ?? this.switchInactiveTrack,
      switchInactiveThumb: switchInactiveThumb ?? this.switchInactiveThumb,
      pdfIconBackground: pdfIconBackground ?? this.pdfIconBackground,
      excelIconBackground: excelIconBackground ?? this.excelIconBackground,
      csvIconBackground: csvIconBackground ?? this.csvIconBackground,
      pdfTextBackground: pdfTextBackground ?? this.pdfTextBackground,
      excelTextBackground: excelTextBackground ?? this.excelTextBackground,
      csvTextBackground: csvTextBackground ?? this.csvTextBackground,
      scannerBackground: scannerBackground ?? this.scannerBackground,
    );
  }

  /// this method of lerp improves color interpolation wen switching from light to dark mode
  /// not giving a sudden switch smoothly changing color it blend colors with each other
  @override
  ThemeExtension<AppColorThemeExtension> lerp(
    covariant final ThemeExtension<AppColorThemeExtension>? other,
    final double t,
  ) {
    if (other is! AppColorThemeExtension) {
      return this;
    }
    return AppColorThemeExtension(
      primaryDefault: .lerp(primaryDefault, other.primaryDefault, t)!,
      primaryPressed: .lerp(primaryPressed, other.primaryPressed, t)!,
      primaryDisabled: .lerp(primaryDisabled, other.primaryDisabled, t)!,
      secondaryDefaultTextBorder: .lerp(
        secondaryDefaultTextBorder,
        other.secondaryDefaultTextBorder,
        t,
      )!,
      secondaryPressedTextBorder: .lerp(
        secondaryPressedTextBorder,
        other.secondaryPressedTextBorder,
        t,
      )!,
      secondaryPressedBackground: .lerp(
        secondaryPressedBackground,
        other.secondaryPressedBackground,
        t,
      )!,
      secondaryDisabledTextBorder: .lerp(
        secondaryDisabledTextBorder,
        other.secondaryDisabledTextBorder,
        t,
      )!,
      accentDefault: .lerp(accentDefault, other.accentDefault, t)!,
      accentPressed: .lerp(accentPressed, other.accentPressed, t)!,
      semanticsTextError: .lerp(
        semanticsTextError,
        other.semanticsTextError,
        t,
      )!,
      semanticsIconError: .lerp(
        semanticsIconError,
        other.semanticsIconError,
        t,
      )!,
      semanticsTextSuccess: .lerp(
        semanticsTextSuccess,
        other.semanticsTextSuccess,
        t,
      )!,
      semanticsIconSuccess: .lerp(
        semanticsIconSuccess,
        other.semanticsIconSuccess,
        t,
      )!,
      textPrimary: .lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: .lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: .lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: .lerp(textDisabled, other.textDisabled, t)!,
      textInversePrimary: .lerp(
        textInversePrimary,
        other.textInversePrimary,
        t,
      )!,
      textInverseSecondary: .lerp(
        textInverseSecondary,
        other.textInverseSecondary,
        t,
      )!,
      surfaceL1: .lerp(surfaceL1, other.surfaceL1, t)!,
      surfaceL2: .lerp(surfaceL2, other.surfaceL2, t)!,
      surfaceL3: .lerp(surfaceL3, other.surfaceL3, t)!,
      separator: .lerp(separator, other.separator, t)!,
      borderInputDefault: .lerp(
        borderInputDefault,
        other.borderInputDefault,
        t,
      )!,
      borderInputFocused: .lerp(
        borderInputFocused,
        other.borderInputFocused,
        t,
      )!,
      iconPrimary: .lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: .lerp(iconSecondary, other.iconSecondary, t)!,
      iconTertiary: .lerp(iconTertiary, other.iconTertiary, t)!,
      scanFrameCorner: .lerp(scanFrameCorner, other.scanFrameCorner, t)!,
      scanLineGradient: .lerp(scanLineGradient, other.scanLineGradient, t)!,
      cameraOverlay: .lerp(cameraOverlay, other.cameraOverlay, t)!,
      flashActive: .lerp(flashActive, other.flashActive, t)!,
      sheetCardSelected: .lerp(sheetCardSelected, other.sheetCardSelected, t)!,
      qrBadgeBackground: .lerp(qrBadgeBackground, other.qrBadgeBackground, t)!,
      qrBadgeText: .lerp(qrBadgeText, other.qrBadgeText, t)!,
      ocrBadgeBackground: .lerp(
        ocrBadgeBackground,
        other.ocrBadgeBackground,
        t,
      )!,
      ocrBadgeText: .lerp(ocrBadgeText, other.ocrBadgeText, t)!,
      scaffoldBackground: .lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      appBarBackground: .lerp(appBarBackground, other.appBarBackground, t)!,
      buttonPrimaryBackground: .lerp(
        buttonPrimaryBackground,
        other.buttonPrimaryBackground,
        t,
      )!,
      buttonSecondaryBackground: .lerp(
        buttonSecondaryBackground,
        other.buttonSecondaryBackground,
        t,
      )!,
      bottomNavBackground: .lerp(
        bottomNavBackground,
        other.bottomNavBackground,
        t,
      )!,
      cardBackground: .lerp(cardBackground, other.cardBackground, t)!,
      dialogBackground: .lerp(dialogBackground, other.dialogBackground, t)!,
      snackbarBackground: .lerp(
        snackbarBackground,
        other.snackbarBackground,
        t,
      )!,
      splashBackground: .lerp(splashBackground, other.splashBackground, t)!,
      splashLogoTint: .lerp(splashLogoTint, other.splashLogoTint, t)!,
      splashText: .lerp(splashText, other.splashText, t)!,
      splashIndicator: .lerp(splashIndicator, other.splashIndicator, t)!,
      switchActiveTrack: .lerp(switchActiveTrack, other.switchActiveTrack, t)!,
      switchActiveThumb: .lerp(switchActiveThumb, other.switchActiveThumb, t)!,
      switchInactiveTrack: .lerp(
        switchInactiveTrack,
        other.switchInactiveTrack,
        t,
      )!,
      switchInactiveThumb: .lerp(
        switchInactiveThumb,
        other.switchInactiveThumb,
        t,
      )!,
      pdfIconBackground: .lerp(pdfIconBackground, other.pdfIconBackground, t)!,
      excelIconBackground: .lerp(
        excelIconBackground,
        other.excelIconBackground,
        t,
      )!,
      csvIconBackground: .lerp(csvIconBackground, other.csvIconBackground, t)!,
      scannerBackground: .lerp(scannerBackground, other.scannerBackground, t)!,
      pdfTextBackground: .lerp(pdfTextBackground, other.pdfTextBackground, t)!,
      excelTextBackground: .lerp(
        excelTextBackground,
        other.excelTextBackground,
        t,
      )!,
      csvTextBackground: .lerp(csvTextBackground, other.csvTextBackground, t)!,
    );
  }
}
