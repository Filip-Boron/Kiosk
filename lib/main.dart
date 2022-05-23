import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiosk/config/theme.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kinder/data/kind_repository.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';
import 'package:kiosk/modules/kinder/presentation/kinder_screen.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_cubit.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_kinder_screen.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_screen.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_shop_screen.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/data/zelt_repository.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';
import 'package:kiosk/modules/zelte/presentation/zelte_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ZeltAdapter());
  Hive.registerAdapter(KindAdapter());
  await Hive.openBox<Zelt>('zelteBox');
  await Hive.openBox<Kind>('kindBox');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return ZeltRepository.initial();
          },
        ),
        RepositoryProvider(
          create: (context) => KindRepository.initial(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<KinderCubit>(
            create: (context) {
              return KinderCubit()..fetchData(context);
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
      ),
    );
  }
}
