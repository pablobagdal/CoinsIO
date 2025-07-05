import 'dart:math';

import 'package:flutter/material.dart';

abstract final class AppColors {
  static const white1 = Color.fromARGB(192, 255, 255, 255);
  static const greenlight1 = Color.fromARGB(255, 212, 250, 230);
  static const black1 = Color.fromARGB(255, 0, 0, 0);
  static const grey1 = Color.fromARGB(255, 153, 153, 153);
  static const greenbright1 = Color.fromARGB(255, 42, 232, 128);
  static const black2 = Color.fromARGB(255, 73, 69, 79);

  // static const black1 = Color(0xFF101010);
  // static const white1 = Color(0xFFFFF7FA);
  // static const grey1 = Color(0xFFF2F2F2);
  // static const grey2 = Color(0xFF4D4D4D);
  // static const grey3 = Color(0xFFA4A4A4);
  // static const whiteTransparent = Color(0x4DFFFFFF);
  // static const blackTransparent = Color(0x4D000000);
  // static const red1 = Color(0xFFE74C3C);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.black1,
    onPrimary: AppColors.white1,
    secondary: AppColors.black1,
    onSecondary: AppColors.white1,
    surface: Colors.white,
    onSurface: AppColors.black1,
    error: Colors.white,
    onError: Colors.red,
  );

  // static const darkColorScheme = ColorScheme(
  //   brightness: Brightness.dark,
  //   primary: AppColors.white1,
  //   onPrimary: AppColors.black1,
  //   secondary: AppColors.white1,
  //   onSecondary: AppColors.black1,
  //   surface: AppColors.black1,
  //   onSurface: Colors.white,
  //   error: Colors.black,
  //   onError: AppColors.red1,
  // );
}

/// Генерирует цвет на основе строки (например, имени категории)
Color colorFromString(String input) {
  final hash = input.codeUnits.fold(0, (prev, elem) => prev + elem);
  final rnd = Random(hash);
  return Color.fromARGB(
    255,
    100 + rnd.nextInt(156), // чтобы не было слишком тёмных
    100 + rnd.nextInt(156),
    100 + rnd.nextInt(156),
  );
}
