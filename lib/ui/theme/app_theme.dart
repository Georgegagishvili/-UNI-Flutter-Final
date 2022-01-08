import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const black = Color(0xff000000);
  static const blackLight = Color(0xff030303);
  static const gray = Color(0xff707070);
  static const lightGray = Color(0xffBAB8B8);
  static const darkTeal = Color(0xff267b7b);
  static const lightTeal = Color(0xff95d3c4);
  static const teal = Color(0xffc3f9ed);
  static const darkCyan = Color(0xffa8e3e8);
  static const lightCyan = Color(0xffcbefef);
  static const white = Color(0xffffffff);


  static const title = TextStyle(
    fontSize: 28,
    color: gray,
    fontWeight: FontWeight.bold,
  );

  static const mediumTitle = TextStyle(
    fontSize: 24,
    color: gray,
    fontWeight: FontWeight.bold,
  );
  static const sixTeen = TextStyle(
    fontSize: 16,
    color: gray,
    fontWeight: FontWeight.bold,
  );

  static ThemeData getThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.poppinsTextTheme(),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: teal),
    );
  }
}
