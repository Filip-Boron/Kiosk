import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/config/theme.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';
import 'package:kiosk/modules/kinder/presentation/kinder_screen.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_cubit.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_kinder_screen.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_screen.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_shop_screen.dart';
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
        BlocProvider<KinderCubit>(
          create: (context) {
            return KinderCubit()..fetchData();
          },
        ),
        BlocProvider<KioskCubit>(
          create: (context) {
            return KioskCubit();
          },
        ),
        BlocProvider<ZelteCubit>(
          create: (context) {
            return ZelteCubit()..fetchData(context);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Kiosk',
        theme: lightTheme,
        routes: {
          '/': (ctx) => const KioskScreen(),
          KioskScreen.routeName: (ctx) => const KioskScreen(),
          ZelteScreen.routeName: (ctx) => const ZelteScreen(),
          KinderScreen.routeName: (ctx) => const KinderScreen(),
          KioskKinderScrren.routeName: (ctx) => const KioskKinderScrren(),
          KioskShopScreen.routeName: (ctx) => const KioskShopScreen(),
        },
      ),
    );
  }
}
