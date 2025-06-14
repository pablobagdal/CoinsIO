import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Color.fromARGB(192, 255, 255, 255),
      indicatorColor: Color.fromARGB(255, 212, 250, 230),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          );
        } else {
          return TextStyle(color: Color.fromARGB(255, 153, 153, 153));
        }
      }),

      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Color.fromARGB(255, 42, 232, 128));
        } else {
          return IconThemeData(color: Color.fromARGB(255, 73, 69, 79));
        }
      }),
    ),
    brightness: Brightness.light,
    useMaterial3: true, // обязательно для NavigationBar
  );

  static final dark = ThemeData(brightness: Brightness.dark);
}
