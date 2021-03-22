import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: Colors.blueGrey,
    chipTheme: ChipThemeData(
      backgroundColor: Colors.amber,
      disabledColor: Colors.grey,
      selectedColor: Colors.yellow,
      secondarySelectedColor: Colors.yellow,
      padding: const EdgeInsets.all(10.0),
      shape: StadiumBorder(side: BorderSide.none),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      secondaryLabelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      brightness: Brightness.dark,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Arial',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 30.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
      button: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurple,
    ),
  );
}
