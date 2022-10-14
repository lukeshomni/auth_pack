import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xff5956E9);
const Color pagesBackgroundColor = Color(0xffF5F5F8);
const Color pagesBackgroundColorDark = Color(0xffF4F6FA);
const Color greyTextColor = Color(0xff9A9A9D);
const Color lightGreyTextColor = Color(0xff868686);
const Color skyBlue = Color(0xff58C0EA);

final appTheme = ThemeData(
  primaryColor: primaryColor,
  fontFamily: GoogleFonts.raleway().fontFamily,
);

TextStyle headlineLarge = GoogleFonts.raleway(
  color: Colors.white,
  fontSize: 65,
  fontWeight: FontWeight.w700,
);
TextStyle headlineMedium = GoogleFonts.raleway(
  color: Colors.black,
  fontSize: 34,
  fontWeight: FontWeight.bold,
);
TextStyle headlineSmall = GoogleFonts.raleway(
  color: Colors.black,
  fontSize: 28,
  fontWeight: FontWeight.w500,
);
TextStyle headline1 = GoogleFonts.raleway(
  color: Colors.black,
  fontSize: 22,
  fontWeight: FontWeight.w500,
);
TextStyle headline2 = GoogleFonts.raleway(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
TextStyle headline3 = GoogleFonts.raleway(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.bold,
);
TextStyle headline4 = GoogleFonts.raleway(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
