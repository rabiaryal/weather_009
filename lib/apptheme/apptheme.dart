import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF0066FF);
  static const Color secondaryColor = Color(0xFF00CC99);
  static const Color accentColor = Color(0xFFFF6600);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF333333);
  static const Color errorColor = Color(0xFFFF0000);

  // Font Family
  static const String fontFamily = 'Roboto';

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;

  // Font Weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Text Styles
  static TextStyle smallTextStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeSmall,
    fontWeight: fontWeightRegular,
    color: textColor,
  );

  static TextStyle mediumTextStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeMedium,
    fontWeight: fontWeightRegular,
    color: textColor,
  );

  static TextStyle largeTextStyle =const  TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLarge,
    fontWeight: fontWeightBold,
    color: textColor,
  );

  // Button Styles
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,  
  foregroundColor: Colors.white, 
    textStyle: const TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeightMedium,
    ),
  );
}
