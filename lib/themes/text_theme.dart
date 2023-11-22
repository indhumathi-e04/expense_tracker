import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme() {
  const FontWeight light = FontWeight.w200;
  const FontWeight regular = FontWeight.w400;
  const FontWeight medium = FontWeight.w500;
  const FontWeight semiBold = FontWeight.w600;
  const FontWeight bold = FontWeight.w800;

  return TextTheme(
    displayLarge: GoogleFonts.lato(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: bold,
    ),
    displayMedium: GoogleFonts.lato(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: bold,
    ),
    displaySmall: GoogleFonts.lato(
      fontSize: 12,
      fontStyle: FontStyle.normal,
      fontWeight: bold,
    ),
    headlineLarge: GoogleFonts.lato(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: semiBold,
    ),
    headlineMedium: GoogleFonts.lato(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: semiBold,
    ),
    headlineSmall: GoogleFonts.lato(
      fontSize: 12,
      fontStyle: FontStyle.normal,
      fontWeight: semiBold,
    ),
    titleLarge: GoogleFonts.lato(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: medium,
    ),
    titleMedium: GoogleFonts.lato(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: medium,
    ),
    titleSmall: GoogleFonts.lato(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: medium,
    ),
    bodyLarge: GoogleFonts.lato(
      fontSize: 15,
      fontStyle: FontStyle.normal,
      fontWeight: regular,
    ),
    bodyMedium: GoogleFonts.lato(
      fontSize: 13,
      fontStyle: FontStyle.normal,
      fontWeight: regular,
    ),
    bodySmall: GoogleFonts.lato(
      fontSize: 11,
      fontStyle: FontStyle.normal,
      fontWeight: regular,
    ),
    labelLarge: GoogleFonts.lato(
      fontSize: 15,
      fontStyle: FontStyle.normal,
      fontWeight: light,
    ),
    labelMedium: GoogleFonts.lato(
      fontSize: 13,
      fontStyle: FontStyle.normal,
      fontWeight: light,
    ),
    labelSmall: GoogleFonts.lato(
      fontSize: 11,
      fontStyle: FontStyle.normal,
      fontWeight: light,
    ),
  );
}
