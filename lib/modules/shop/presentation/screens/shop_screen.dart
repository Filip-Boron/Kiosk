import 'package:flutter/material.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  static const routeName = '/shopScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      drawer: const CustomDrawer(),
      body: const Text(''),
    );
  }
}
