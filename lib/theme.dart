import 'package:flutter/material.dart';

abstract class CustomTheme {
  static final THEME = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.amber[400],
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
    appBarTheme: AppBarTheme(
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
  );
}
