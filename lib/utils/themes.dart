import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_colors.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: Color(0xffFAFAFA),
      textColor: Color(0xff8D9194),
      iconColor: Color(0xff8D9194),
    ),
    toggleableActiveColor: Colors.teal,
    extensions: <ThemeExtension<dynamic>>[
      const CustomColors(
          bodyBackground: Color(0xFFffffff),
          headerBackground: Color(0xFFE0E0E0),
          backPaintColor: Color(0xFFF7FAFE),
          fieldPaintColor: Color(0xFFE3E7ED)),
    ],
    shadowColor: const Color(0XFF000000),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all(const Color(0xFF3F3E3E)))),
    backgroundColor: const Color(0xffEEEEEE),
    primaryColor: const Color(0xFFDFE8ED),
    cardColor: const Color(0xffFAFAFA),
    bottomAppBarColor: const Color(0xFFE4F8Ff),
    scaffoldBackgroundColor: const Color(0xFFEEEEEE),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white70,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: Color(0xff333A40),
      textColor: Color(0xff848C97),
      iconColor: Color(0xff848C97),
    ),
    toggleableActiveColor: Colors.teal,
    extensions: <ThemeExtension<dynamic>>[
      const CustomColors(
          bodyBackground: Color(0xFF1C273C),
          headerBackground: Color(0xff141C2B),
          backPaintColor: Color(0xFF141C2B),
          fieldPaintColor: Color(0xFF596882))
    ],
    scaffoldBackgroundColor: const Color(0xff272727),
    backgroundColor: const Color(0xff272727),
    primaryColor: const Color(0xff282B30),
    cardColor: const Color(0xff333A40),
    shadowColor: const Color.fromARGB(255, 152, 152, 152),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.grey.shade700,
    ),
    bottomAppBarColor: const Color(0xFF151515),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all(const Color(0xfff4f4f4)))),
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light, color: Colors.white),
  );
}
