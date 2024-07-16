import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

ThemeData lightTheme=ThemeData(
  scaffoldBackgroundColor:whiteColor,
    primaryColor: whiteColor,
    primaryColorDark: basicColor,
    iconTheme: const IconThemeData(color:basicColor),
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'ABeeZee',
  colorScheme: const ColorScheme.light(
    background: whiteColor,
    primary: basicColor,
    secondary: secondaryColor,
    tertiary: thirdColor,
  ),
  iconButtonTheme: const IconButtonThemeData(style: ButtonStyle(iconColor:MaterialStatePropertyAll(basicColor)))
);
ThemeData darkTheme=ThemeData(
  primaryColor: basicColor,
  primaryColorLight: whiteColor,
  scaffoldBackgroundColor:basicColor,
  iconTheme: const IconThemeData(color:whiteColor),
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'ABeeZee',
  colorScheme: const ColorScheme.dark(
    background: basicColor,
    primary: whiteColor,
    secondary: secondaryColor,
    tertiary: thirdColor,
  ),
);