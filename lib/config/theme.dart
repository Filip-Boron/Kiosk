import 'package:flutter/material.dart';
import 'package:kiosk/constants/app_constants.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: lightPrimary,
  primaryColorDark: lightPrimaryDark,
  primaryColorLight: lightPrimaryLight,
  textTheme: lightTextTheme,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAsscentColor),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: lightPrimary,
    iconTheme: const IconThemeData(color: Colors.black, size: iconSizeStandard),
    actionsIconTheme:
        const IconThemeData(color: Colors.black, size: iconSizeStandard),
    titleTextStyle: lightAppBarTitel,
  ),
);
