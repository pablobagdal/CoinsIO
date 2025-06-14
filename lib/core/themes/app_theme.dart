import 'package:coinio_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.white1,
      indicatorColor: Color.fromARGB(255, 212, 250, 230),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: AppColors.black1,
            fontWeight: FontWeight.bold,
          );
        } else {
          return TextStyle(color: AppColors.grey1);
        }
      }),

      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: AppColors.greenbright1);
        } else {
          return IconThemeData(color: AppColors.black2);
        }
      }),
    ),
    brightness: Brightness.light,
    useMaterial3: true, // обязательно для NavigationBar
  );

  static final dark = ThemeData(brightness: Brightness.dark);
}
