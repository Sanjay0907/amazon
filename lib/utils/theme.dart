import 'package:amazon/constants/color_and_images.dart';
import 'package:amazon/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: white,
  colorScheme: const ColorScheme.light(primary: GlobalVariables.secondaryColor),
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      color: black,
    ),
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 30,
      color: black,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.montserrat(
      fontSize: 25,
      color: black,
      fontWeight: FontWeight.bold,
    ),
    headline3: GoogleFonts.montserrat(
      fontSize: 24,
      color: black,
    ),
    headline4: GoogleFonts.montserrat(
      fontSize: 20,
      color: black,
    ),
    headline5: GoogleFonts.montserrat(
      fontSize: 16,
      color: black,
    ),
    headline6: GoogleFonts.montserrat(
      fontSize: 14,
      color: black,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontSize: 16,
      color: black,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontSize: 12,
      color: black,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: GoogleFonts.montserrat(
      fontSize: 15,
      color: black,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.montserrat(
      fontSize: 12,
      color: black,
      fontWeight: FontWeight.w400,
    ),
    button: GoogleFonts.montserrat(
      fontSize: 16,
      color: black,
      fontWeight: FontWeight.w500,
    ),
  ),
);
