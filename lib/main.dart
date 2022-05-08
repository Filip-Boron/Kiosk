import 'package:flutter/material.dart';
import 'package:kiosk/config/theme.dart';
import 'package:kiosk/modules/shop/presentation/screens/shop_screen.dart';
import 'package:kiosk/modules/zelte/presentation/zelte_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiosk',
      theme: lightTheme,
      routes: {
        '/': (ctx) => const ShopScreen(),
        ShopScreen.routeName: (ctx) => const ShopScreen(),
        ZelteScreen.routeName: (ctx) => const ZelteScreen(),
      },
    );
  }
}
