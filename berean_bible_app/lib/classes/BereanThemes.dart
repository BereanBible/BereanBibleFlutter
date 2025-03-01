import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

const appColors_main = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 0, 0, 0),
  onPrimary: Color.fromARGB(255, 75, 255, 237),
  secondary: Color.fromARGB(255, 0, 147, 132),
  onSecondary: Color.fromARGB(255, 114, 75, 255),
  tertiary: Color.fromARGB(255, 0, 0, 180),
  onTertiary: Color.fromARGB(255, 126, 126, 126),
  outline: Color.fromARGB(255, 126, 126, 126),
  error: Color.fromARGB(255, 255, 162, 0),
  onError: Color.fromARGB(255, 184, 0, 0),
  surface: Color.fromARGB(200, 30, 30, 30),
  onSurface: Color.fromARGB(255, 197, 181, 255),
  // background: 200, 30, 30, 30
);

final appThemeMain = ThemeData(
  colorScheme: appColors_main,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: appColors_main.onPrimary),
  )
);