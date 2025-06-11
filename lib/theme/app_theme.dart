import 'package:flutter/material.dart';

class AppTheme {
  // static final light = ThemeData(
  //   brightness: Brightness.light,
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: Color(0xD4FAE6),
  //     selectedItemColor: Color.fromARGB(0, 52, 139, 91),
  //     unselectedItemColor: Color(0x49454F),
  //     selectedIconTheme: IconThemeData(
  //       color: Color(0x2AE881),
  //       // color: Color(0x2AE881),
  //     ),
  //   ),
  // );
  static final light = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 234, 0, 255),
      indicatorColor: Color.fromARGB(255, 222, 49, 43),
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(color: Color.fromARGB(255, 103, 23, 223)),
      ),
      // iconTheme: WidgetStateProperty.all(
      //   IconThemeData(color: Color.fromARGB(255, 221, 255, 0)),
      // ),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Color.fromARGB(255, 221, 255, 0));
        } else {
          return IconThemeData(color: Color.fromARGB(255, 103, 23, 223));
        }
      }),
    ),
    brightness: Brightness.light,
    // colorScheme: ColorScheme.light(
    //   primary: Color(0xFF348B5B),
    //   secondary: Color(0xFFD4FAE6),
    //   surface: Colors.white,
    //   onPrimary: Colors.white,
    //   onSecondary: Color(0xFF49454F),
    //   onSurface: Color(0xFF49454F),
    // ),
    useMaterial3: true, // обязательно для NavigationBar
  );

  static final dark = ThemeData(brightness: Brightness.dark);
}
