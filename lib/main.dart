import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/config/theme.dart';
import 'package:kiosk/modules/shop/presentation/screens/shop_screen.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';
import 'package:kiosk/modules/zelte/presentation/zelte_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ZelteCubit>(
          create: (context) {
            return ZelteCubit();
          },
        )
      ],
      child: MaterialApp(
        title: 'Kiosk',
        theme: lightTheme,
        routes: {
          '/': (ctx) => const ShopScreen(),
          ShopScreen.routeName: (ctx) => const ShopScreen(),
          ZelteScreen.routeName: (ctx) => const ZelteScreen(),
        },
      ),
    );
  }
}
