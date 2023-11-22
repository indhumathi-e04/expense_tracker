import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'text_theme.dart';

ThemeData themeData() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    textTheme: textTheme(),
  );
}
