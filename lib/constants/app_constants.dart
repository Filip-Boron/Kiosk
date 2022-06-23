import 'package:flutter/material.dart';

const String version = 'v0.15.0';

const double iconSizeStandard = 40;
const double paddingStandard = 20;
const double marginStandard = 20;

//Light Theme
const Color lightPrimary = Color(0xff03A9F4);
const Color lightPrimaryLight = Color(0xffB3E5FC);
const Color lightPrimaryDark = Color(0xff0288D1);
const Color lightAsscentColor = Color(0xff536DFE);

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

const IconData zeltIcon = Icons.festival;

const List<double> betragList = [ 0.10, 0.50, 1.00, 1.50, 2];
