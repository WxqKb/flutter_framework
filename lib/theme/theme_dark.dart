import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Color(0xFF00B4ED),
  accentColor: Color(0xFFFCB622),
  scaffoldBackgroundColor: Color(0xFF060606),
  backgroundColor: Color(0xFF060606),
  unselectedWidgetColor: Color(0xFFC9C9C9),
  errorColor: Color(0xFFFF6D73),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    disabledColor: Color(0xFF262626),
  ),
  disabledColor: Color(0xFFC9C9C9),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color(0xFF242426),
    labelStyle: TextStyle(
      fontSize: 13.0,
      color: Color(0xFF88888F),
    ),
    helperStyle: TextStyle(
      fontSize: 10.0,
      color: Color(0xFF88888F),
    ),
    hintStyle: TextStyle(
      fontSize: 16.0,
      color: Color(0xFF88888F),
    ),
    errorStyle: TextStyle(
      fontSize: 10.0,
      color: Color(0xFFFF6D73),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF8E8E93),
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF8D949E),
  ),
  primaryIconTheme: IconThemeData(
    color: Color(0xFF00B4ED),
  ),
  accentIconTheme: IconThemeData(
    color: Color(0xFFD1D1D6),
  ),
  cardTheme: CardTheme(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    color: Color(0xFF262626),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 17.0,
    ),
    subtitle1: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      color: Color(0xFF7B7B81),
      fontSize: 13.0,
    ),
    bodyText1: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
    ),
    button: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
    ),
    overline: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 13.0,
    ),
  ),
  primaryTextTheme: TextTheme(
    overline: TextStyle(
      color: Color(0xFF00B4ED),
      fontSize: 13.0,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    elevation: 0.0,
    color: Color(0xFF181818),
  ),
  dividerColor: Color(0xFF464649),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    brightness: Brightness.dark,
    color: Color(0xFF000000),
    iconTheme: IconThemeData(
      color: Color(0xFF6C6C6C),
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0xFF00B4ED),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF272831),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
    ),
  ),
  canvasColor: Color(0xFF272831),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF272831),
    textStyle: TextStyle(
      color: Color(0xFF7B7B81),
      fontSize: 13.0,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0xFF00B4ED),
  ),
);
