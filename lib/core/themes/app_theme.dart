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
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
        final states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: AppColors.black1,
            fontWeight: FontWeight.bold,
          );
        } else {
          return const TextStyle(color: AppColors.grey1);
        }
      }),

      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((final states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.greenbright1);
        } else {
          return const IconThemeData(color: AppColors.black2);
        }
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      backgroundColor: AppColors.greenbright1,
    ),
    // splashColor: AppColors.greenbright1.withOpacity(0.2),
    // highlightColor: AppColors.greenbright1.withOpacity(0.1),
    // hoverColor: AppColors.greenbright1.withOpacity(0.08),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  // static final light = ThemeData(
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: Color.fromARGB(255, 42, 232, 128),
  //     brightness: Brightness.light,
  //   ),
  //   useMaterial3: true, // важно для Material 3
  // );
  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 17, 52, 142),
      brightness: Brightness.dark,
    ),
    useMaterial3: true, // важно для Material 3
  );
}
