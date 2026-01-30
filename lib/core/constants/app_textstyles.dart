import 'package:flutter/cupertino.dart';

class AppTextStyles {
  static const String fontFamilyAirBnbCreal = 'AirbnbCereal';
  static const String fontFamilyInter = 'Inter';

  /// Naming convention:
  /// [font][W=FontWeights][S=FontSize][Lh=LineHeight][Ls=LetterSpacing]
  /// Example: interW900S36Lh48Ls0 → Inter, weight 900, size 36, lineHeight 48, letterSpacing 0

  static const TextStyle airbnbCerealW400S12Lh16 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w400,
    fontSize: 12,
    height: 16 / 12,
    decoration: .none,
    textBaseline: .alphabetic,
  );
  static const TextStyle airbnbCerealW400S16Lh24Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    decoration: .none,
  );

  static const TextStyle airbnbCerealW500S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    decoration: .none,
  );

  static const TextStyle airbnbCerealW400S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
  );

  static const TextStyle interW600S36Lh48Ls0 = TextStyle(
    fontWeight: .w600,
    fontSize: 36,
    height: 48 / 36,
    letterSpacing: 0,
    decoration: .none,
    fontFamily: fontFamilyInter,
  );

  static const TextStyle interW400S14Lh21Ls0 = TextStyle(
    fontWeight: .w400,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0,
    decoration: .none,
    fontFamily: fontFamilyInter,
  );
  static const TextStyle interW700S12Lh16 = TextStyle(
    fontFamily: fontFamilyInter,
    fontWeight: .w700,
    fontSize: 12,
    height: 16 / 12,
    decoration: .none,
  );
  static const TextStyle interW700S22Lh28Ls0 = TextStyle(
    fontFamily: fontFamilyInter,
    fontWeight: .w700,
    fontSize: 22,
    height: 28 / 20,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle airbnbCerealW600S18Lh24Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w600,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle interW400S14Lh20Ls0_2 = TextStyle(
    fontFamily: fontFamilyInter,
    fontWeight: .w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.2,
    decoration: .none,
  );
  static const TextStyle interW400S12Lh16Ls0 = TextStyle(
    fontFamily: fontFamilyInter,
    fontWeight: .w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle airbnbCerealW600S20Lh28Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w600,
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle airbnbCerealW400S12Lh16Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle airbnbCerealW500S16Lh24Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle airbnbCerealW600S16Lh24Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    decoration: .none,
  );
  static const TextStyle airbnbCerealW600S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamilyAirBnbCreal,
    fontWeight: .w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    decoration: .none,
  );
}
