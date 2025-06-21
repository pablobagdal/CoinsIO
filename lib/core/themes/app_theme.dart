import 'package:coinio_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.black1, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.black2, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.grey1, fontSize: 12),
      titleLarge: TextStyle(
        color: Colors.amber,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenbright1,
      foregroundColor: AppColors.black1,
      elevation: 0,
      // Используйте тот же стиль, что и в textTheme.titleLarge
      titleTextStyle: TextStyle(
        color: AppColors.black1,
        fontSize: 22,
        // fontWeight: FontWeight.bold,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.white1,
      indicatorColor: const Color.fromARGB(255, 212, 250, 230),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: AppColors.black1,
            fontWeight: FontWeight.bold,
          );
        } else {
          return const TextStyle(color: AppColors.grey1);
        }
      }),

      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.greenbright1);
        } else {
          return const IconThemeData(color: AppColors.black2);
        }
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      backgroundColor: AppColors.greenbright1,
    ),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static final dark = ThemeData(brightness: Brightness.dark);
}
