import 'package:flutter/cupertino.dart';

class AppTextStyles {
  static const String fontFamily = 'AirbnbCereal';
  static const TextStyle airbnbCerealW400S12Lh16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );
  static const TextStyle airbnbCerealW700S24Lh32LsMinus1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: -1,
    decoration: TextDecoration.none,
  );

  static const TextStyle airbnbCerealW500S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle airbnbCerealW500S18Lh24Ls0 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0,
  );

  static const TextStyle airbnbCerealW400S14Lh20Ls0 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
  );
}
