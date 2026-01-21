import 'package:flutter/material.dart';

abstract class AppThemeColors {
  Color get white;

  Color get black;

  Color get red;

  Color get slate;

  Color get darkGrey;

  Color get primaryBlue;

  Color get ghostWhite;

  Color get lightGray;

  Color get kellyGreen;

  Color get cloudBlue;
}

class AppColorsDark extends AppThemeColors {
  @override
  Color get white => Colors.black;

  @override
  Color get black => Colors.white;

  @override
  Color get red => const Color(0xF012E4DB);

  @override
  Color get slate => const Color(0xFF635C50);

  @override
  Color get darkGrey => const Color(0xFFC5C5C5);

  @override
  Color get primaryBlue => const Color(0xFFD4B803);

  @override
  Color get ghostWhite => const Color(0xFF0A0A12);

  @override
  Color get lightGray => const Color(0xFFEAECF0);

  @override
  Color get kellyGreen => const Color(0xFF253E1F);

  @override
  Color get cloudBlue => const Color(0xFFC5C5C5);
}

class AppColorsLight extends AppThemeColors {
  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get red => const Color(0xFFED1B24);

  @override
  Color get slate => const Color(0xFF9CA3AF);

  @override
  Color get darkGrey => const Color(0xFF3A3A3A);

  @override
  Color get primaryBlue => const Color(0xFF2B47FC);

  @override
  Color get ghostWhite => const Color(0xFFF6F9FF);

  @override
  Color get lightGray => const Color(0xFFEAECF0);

  @override
  Color get kellyGreen => const Color(0xFF3BA935);

  @override
  Color get cloudBlue => const Color(0xFCEBECFF);
}
