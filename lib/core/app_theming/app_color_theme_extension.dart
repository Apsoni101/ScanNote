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
      primaryDefault: Color.lerp(primaryDefault, other.primaryDefault, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      primaryDisabled: Color.lerp(primaryDisabled, other.primaryDisabled, t)!,
      secondaryDefaultTextBorder: Color.lerp(
        secondaryDefaultTextBorder,
        other.secondaryDefaultTextBorder,
        t,
      )!,
      secondaryPressedTextBorder: Color.lerp(
        secondaryPressedTextBorder,
        other.secondaryPressedTextBorder,
        t,
      )!,
      secondaryPressedBackground: Color.lerp(
        secondaryPressedBackground,
        other.secondaryPressedBackground,
        t,
      )!,
      secondaryDisabledTextBorder: Color.lerp(
        secondaryDisabledTextBorder,
        other.secondaryDisabledTextBorder,
        t,
      )!,
      accentDefault: Color.lerp(accentDefault, other.accentDefault, t)!,
      accentPressed: Color.lerp(accentPressed, other.accentPressed, t)!,
      semanticsTextError: Color.lerp(
        semanticsTextError,
        other.semanticsTextError,
        t,
      )!,
      semanticsIconError: Color.lerp(
        semanticsIconError,
        other.semanticsIconError,
        t,
      )!,
      semanticsTextSuccess: Color.lerp(
        semanticsTextSuccess,
        other.semanticsTextSuccess,
        t,
      )!,
      semanticsIconSuccess: Color.lerp(
        semanticsIconSuccess,
        other.semanticsIconSuccess,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      textInversePrimary: Color.lerp(
        textInversePrimary,
        other.textInversePrimary,
        t,
      )!,
      textInverseSecondary: Color.lerp(
        textInverseSecondary,
        other.textInverseSecondary,
        t,
      )!,
      surfaceL1: Color.lerp(surfaceL1, other.surfaceL1, t)!,
      surfaceL2: Color.lerp(surfaceL2, other.surfaceL2, t)!,
      surfaceL3: Color.lerp(surfaceL3, other.surfaceL3, t)!,
      separator: Color.lerp(separator, other.separator, t)!,
      borderInputDefault: Color.lerp(
        borderInputDefault,
        other.borderInputDefault,
        t,
      )!,
      borderInputFocused: Color.lerp(
        borderInputFocused,
        other.borderInputFocused,
        t,
      )!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconTertiary: Color.lerp(iconTertiary, other.iconTertiary, t)!,
      scanFrameCorner: Color.lerp(scanFrameCorner, other.scanFrameCorner, t)!,
      scanLineGradient: Color.lerp(
        scanLineGradient,
        other.scanLineGradient,
        t,
      )!,
      cameraOverlay: Color.lerp(cameraOverlay, other.cameraOverlay, t)!,
      flashActive: Color.lerp(flashActive, other.flashActive, t)!,
      sheetCardSelected: Color.lerp(
        sheetCardSelected,
        other.sheetCardSelected,
        t,
      )!,
      qrBadgeBackground: Color.lerp(
        qrBadgeBackground,
        other.qrBadgeBackground,
        t,
      )!,
      qrBadgeText: Color.lerp(qrBadgeText, other.qrBadgeText, t)!,
      ocrBadgeBackground: Color.lerp(
        ocrBadgeBackground,
        other.ocrBadgeBackground,
        t,
      )!,
      ocrBadgeText: Color.lerp(ocrBadgeText, other.ocrBadgeText, t)!,
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      appBarBackground: Color.lerp(
        appBarBackground,
        other.appBarBackground,
        t,
      )!,
      buttonPrimaryBackground: Color.lerp(
        buttonPrimaryBackground,
        other.buttonPrimaryBackground,
        t,
      )!,
      buttonSecondaryBackground: Color.lerp(
        buttonSecondaryBackground,
        other.buttonSecondaryBackground,
        t,
      )!,
      bottomNavBackground: Color.lerp(
        bottomNavBackground,
        other.bottomNavBackground,
        t,
      )!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      dialogBackground: Color.lerp(
        dialogBackground,
        other.dialogBackground,
        t,
      )!,
      snackbarBackground: Color.lerp(
        snackbarBackground,
        other.snackbarBackground,
        t,
      )!,
      splashBackground: Color.lerp(
        splashBackground,
        other.splashBackground,
        t,
      )!,
      splashLogoTint: Color.lerp(splashLogoTint, other.splashLogoTint, t)!,
      splashText: Color.lerp(splashText, other.splashText, t)!,
      splashIndicator: Color.lerp(splashIndicator, other.splashIndicator, t)!,
    );
  }
}
