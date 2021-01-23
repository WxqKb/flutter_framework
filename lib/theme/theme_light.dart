import 'package:flutter/material.dart';

final ThemeData lightTheme =  ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Color(0xFF00B4ED),
  accentColor: Color(0xFFFCB622),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  backgroundColor: Color(0xFFFFFFFF),
  unselectedWidgetColor: Color(0xFFC9C9C9),
  errorColor: Color(0xFFFF6D73),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    disabledColor: Color(0xFF9C9C9C),
  ),
  disabledColor: Color(0xFFC9C9C9),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color(0xFFF1F2F3),
    labelStyle: TextStyle(
      fontSize: 13.0,
      color: Color(0xFFC7C7CC),
    ),
    hintStyle: TextStyle(
      fontSize: 16.0,
      color: Color(0xFFC7C7C7),
    ),
    helperStyle: TextStyle(
      fontSize: 10.0,
      color: Color(0xFFC7C7CC),
    ),
    errorStyle: TextStyle(
      fontSize: 10.0,
      color: Color(0xFFFF6D73),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC7C7CC),
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF1B1B1B),
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
    color: Color(0xFFFFFFFF),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 17.0,
    ),
    subtitle1: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      color: Color(0xFF8E8E93),
      fontSize: 13.0,
    ),
    bodyText1: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 16.0,
    ),
    button: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
    ),
    overline: TextStyle(
      color: Color(0xFF1B1B1B),
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
    color: Color(0xFFFFFFFF),
  ),
  dividerColor: Color(0xFFF1F2F3),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    brightness: Brightness.light,
    color: Color(0xFFFFFFFF),
    iconTheme: IconThemeData(
      color: Color(0xFF1B1B1B),
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0xFF1B1B1B),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFF1B1B1B),
      fontSize: 16.0,
    ),
  ),
  canvasColor: Color(0xFFFFFFFF),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFFFFFFF),
    textStyle: TextStyle(
      color: Color(0xFF8E8E93),
      fontSize: 13.0,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0xFF00B4ED),
  ),
);