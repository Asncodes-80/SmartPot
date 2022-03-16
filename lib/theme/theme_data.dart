import 'package:flutter/material.dart';
import 'package:shahjump/Theme/colors.dart';
import 'package:shahjump/config/main.dart';

class CustomizedTheme {
  static final ThemeData defaultTheme = _themeBuilder();

  static ThemeData _themeBuilder() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: backgroundLight,
      backgroundColor: backgroundLight,
      // TODO: Change fontFamily style in switch mode of en/fa
      textTheme: base.textTheme.copyWith(
        headline1: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 93.0,
          letterSpacing: -1.5,
        ),
        headline2: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 58.0,
          letterSpacing: -0.5,
        ),
        headline3: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 47.0,
          letterSpacing: 0,
        ),
        headline4: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 33.0,
          letterSpacing: 0.25,
        ),
        // In a card overline, Headline 5 is title of a card
        // and in description is body2.
        headline5: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 23.0,
          letterSpacing: 0,
        ),
        // We usually use Headline6 for appBar title.
        headline6: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 19.0,
          letterSpacing: 0.15,
        ),
        // subtitle of a card
        subtitle1: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 16.0,
          letterSpacing: 0.15,
        ),
        subtitle2: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 14.0,
          letterSpacing: 0.1,
        ),
        bodyText1: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 16.0,
          letterSpacing: 0.5,
        ),
        bodyText2: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 14.0,
          letterSpacing: 0.25,
        ),
        button: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 14.0,
          letterSpacing: 1.25,
        ),
        caption: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 12.0,
          letterSpacing: 0.4,
        ),
        overline: base.textTheme.titleSmall?.copyWith(
          fontFamily: enFontFamily,
          fontSize: 10.0,
          letterSpacing: 1.5,
        ),
      ),
      appBarTheme: base.appBarTheme.copyWith(),
    );
  }
}
