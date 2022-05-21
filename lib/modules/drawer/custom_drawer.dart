import 'package:flutter/material.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/drawer/custom_drawer_header.dart';
import 'package:kiosk/modules/drawer/custom_list_tile.dart';
import 'package:kiosk/modules/kinder/presentation/kinder_screen.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_screen.dart';
import 'package:kiosk/modules/zelte/presentation/zelte_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(microseconds: 500),
        width: 300,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: lightPrimaryLight.withOpacity(1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingStandard),
          child: Column(
            children: [
              const SizedBox(height: marginStandard),
              const CustomDrawerHeader(),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(height: marginStandard),
              const CustomListTitle(
                icon: Icons.home,
                title: 'Startseite',
                route: KioskScreen.routeName,
              ),
              const CustomListTitle(
                icon: zeltIcon,
                title: 'Zelte',
                route: ZelteScreen.routeName,
              ),
              const CustomListTitle(
                icon: Icons.account_circle,
                title: 'Kinder',
                route: KinderScreen.routeName,
              ),
              const CustomListTitle(
                icon: Icons.add_shopping_cart,
                title: 'Artikel',
                route: KioskScreen.routeName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
