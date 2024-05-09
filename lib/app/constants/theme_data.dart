import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF191919);
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kSecondaryColor = Color(0xff292929);
const Color kAccentColor = Color(0xFF191919);
const Color kTextColor = Color(0xff292929);
const Color kTitleColor = Color(0xFF191919);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kBlackColor = Color(0xFF000000);
const Color kGreyColor = Color(0xFF9E9E9E);
const Color kRedColor = Color(0xFFE53935);
const Color kGreenColor = Color(0xFF43A047);
const Color kBlueColor = Color(0xFF1E88E5);
const Color kYellowColor = Color(0xFFFFEB3B);
const Color kOrangeColor = Color(0xFFFF9800);
const Color kPurpleColor = Color(0xFF9C27B0);
const Color kPinkColor = Color(0xFFE91E63);

const MaterialColor kPrimary = MaterialColor(
  0xFF1E1E1E,
  <int, Color>{
    50: Color(0xFF1E1E1E),
    100: Color(0xFF1E1E1E),
    200: Color(0xFF1E1E1E),
    300: Color(0xFF1E1E1E),
    400: Color(0xFF1E1E1E),
    500: Color(0xFF1E1E1E),
    600: Color(0xFF1E1E1E),
    700: Color(0xFF1E1E1E),
    800: Color(0xFF1E1E1E),
    900: Color(0xFF1E1E1E),
  },
);

ThemeData lightTheme(context) => ThemeData(
      primaryColor: kPrimaryColor,
      primarySwatch: kPrimary,
      scaffoldBackgroundColor: kBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: kWhiteColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: kTitleColor,
          fontSize: 18,
          fontFamily: 'Circular Std',
          fontWeight: FontWeight.bold,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kPrimaryColor,
        selectionColor: kPrimaryColor,
        selectionHandleColor: kPrimaryColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: kTitleColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Circular Std',
        ),
        displayMedium: TextStyle(
          color: kTitleColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Circular Std',
        ),
        displaySmall: TextStyle(
          color: kTitleColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Circular Std',
        ),
        headlineMedium: TextStyle(
          color: kTitleColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Circular Std',
        ),
        headlineSmall: TextStyle(
          color: kTitleColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: kTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Circular Std',
        ),
        bodyLarge: TextStyle(
          color: kTextColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: kTextColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Circular Std',
        ),
        titleMedium: TextStyle(
          color: kTextColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        titleSmall: TextStyle(
          color: kTextColor,
          fontSize: 10,
          fontWeight: FontWeight.normal,
          fontFamily: 'Circular Std',
        ),
        labelLarge: TextStyle(
          color: kTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Circular Std',
        ),
        bodySmall: TextStyle(
          color: kTextColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelSmall: TextStyle(
          color: kTextColor,
          fontSize: 10,
          fontWeight: FontWeight.normal,
          fontFamily: 'Circular Std',
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: kSecondaryColor,
        primary: kPrimaryColor,
        onPrimary: kWhiteColor,
        onSurface: kAccentColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: kPrimaryColor // button text color
            ),
      ),
    );

class GoogleFonts {}
