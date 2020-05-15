import 'package:flutter/material.dart';

class LocalThemes {
  static ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.blue),
        headline2: TextStyle(color: Colors.blue),
        headline3: TextStyle(color: Colors.blue),
        headline4: TextStyle(color: Colors.blue),
        headline5: TextStyle(color: Colors.blue),
        //h6 appbar
        headline6: TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(color: Colors.blue),
        bodyText2: TextStyle(color: Colors.blue),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.blue),
      headline2: TextStyle(color: Colors.blue),
      headline3: TextStyle(color: Colors.blue),
      headline4: TextStyle(color: Colors.blue),
      headline5: TextStyle(color: Colors.blue),
      //h6 appbar
      headline6: TextStyle(
        color: Colors.blue,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'RobotoMono',
      ),
      bodyText1: TextStyle(color: Colors.blue),
      bodyText2: TextStyle(color: Colors.blue),
      subtitle1: TextStyle(color: Colors.blue),
      subtitle2: TextStyle(color: Colors.blue),
    ),
    brightness: Brightness.light,
  );
}

class FontNames {
  static const String OPEN_SANS_BOLD =
      'fonts/Roboto_Mono/RobotoMono-Regular.ttf';
// fonts/Roboto_Mono/RobotoMono-Bold.ttf';
}
