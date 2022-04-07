import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

myThemeData() {
  return ThemeData(
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: K_whiteColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    ),
  );
}
