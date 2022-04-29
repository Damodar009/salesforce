import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

const MaterialColor kPrimaryColor = MaterialColor(
  0xFF6C65D1,
  <int, Color>{
    50: Color(0xFFc02a29),
    100: Color(0xFFc02a29),
    200: Color(0xFFc02a29),
    300: Color(0xFFc02a29),
    400: Color(0xFFc02a29),
    500: Color(0xFFc02a29),
    600: Color(0xFFc02a29),
    700: Color(0xFFc02a29),
    800: Color(0xFFc02a29),
    900: Color(0xFFc02a29),
  },
);

final ThemeData theme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
// Define the default brightness and colors.
  unselectedWidgetColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  accentColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: kPrimaryColor,
      primaryColorDark: AppColors.primaryColor,
      accentColor: Colors.white,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      errorColor: Colors.red[700]),
//  platform: TargetPlatform.iOS,
// Define the default font family.
  fontFamily: 'DMSans',
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 2,

    iconTheme: IconThemeData(color: AppColors.primaryColor, size: 10),
// backgroundColor: AppColors.appBarBackground,
    titleTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'DMSans'),
    toolbarTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'DMSans'),
    textTheme: TextTheme(
      headline4: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline6: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
         ),
    ),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: AppColors.primaryColor,
  ),
// for others(Android, Fuchsia)
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
  ),
// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    headline4: TextStyle(
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    headline1: TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: 'DMSans'),
    headline6: TextStyle(
        fontSize: 36.0, fontStyle: FontStyle.normal, fontFamily: 'DMSans'),
    bodyText2: TextStyle(
        fontSize: 16.0, fontFamily: 'DMSans', color: AppColors.primaryColor),
  ),
);
