import 'package:flutter/cupertino.dart';

class AppTextStyles {
  static const String fontFamilyAirBnbCreal = 'AirbnbCereal';
  static const String fontFamilyInter = 'Inter';

  /// Naming convention:
  /// [font][W=FontWeight][S=FontSize][Lh=LineHeight][Ls=LetterSpacing]
  /// Example: interW900S36Lh48Ls0 → Inter, weight 900, size 36, lineHeight 48, letterSpacing 0

  static const TextStyle airbnbCerealW400S12Lh16 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle airbnbCerealW700S24Lh32LsMinus1 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: -1,
    decoration: TextDecoration.none,
  );

  static const TextStyle airbnbCerealW500S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle airbnbCerealW500S18Lh24Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0,
  );

  static const TextStyle airbnbCerealW400S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
  );

  static const TextStyle interW600S36Lh48Ls0 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 36,
    height: 48 / 36,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    fontFamily: fontFamilyInter,
  );

  static const TextStyle interW400S14Lh21Ls0 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    fontFamily: fontFamilyInter,
  );
  static const TextStyle interW700S12Lh16 = TextStyle(
    fontFamily: fontFamilyInter,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16 / 12,
    decoration: TextDecoration.none,
  );
}
