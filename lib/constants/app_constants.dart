import 'package:flutter/material.dart';

const double iconSizeStandard = 40;
const double paddingStandard = 20;
const double marginStandard = 20;

//Light Theme
const Color lightPrimary = Color(0xff673AB7);
const Color lightPrimaryLight = Color(0xffD1C4E9);
const Color lightPrimaryDark = Color(0xff512DA8);
const Color lightAsscentColor = Color(0xffFF9800);

final TextTheme lightTextTheme = ThemeData.light().textTheme.copyWith(
      headline3:
          ThemeData.light().textTheme.headline3!.copyWith(color: Colors.black),
      headline4:
          ThemeData.light().textTheme.headline4!.copyWith(color: Colors.black),
      headline5:
          ThemeData.light().textTheme.headline5!.copyWith(color: Colors.black),
      bodyText1: const TextStyle(fontSize: 16, color: Colors.black),
    );

final TextStyle lightAppBarTitel = ThemeData.light()
    .textTheme
    .headline4!
    .copyWith(color: Colors.black, fontSize: 32);
