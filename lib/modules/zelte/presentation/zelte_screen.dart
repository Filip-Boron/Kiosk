import 'package:flutter/material.dart';
import 'package:kiosk/modules/app/widgets/custom_floating_button.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';
import 'package:kiosk/modules/zelte/presentation/widgets/zelte_list.dart';

class ZelteScreen extends StatelessWidget {
  const ZelteScreen({Key? key}) : super(key: key);

  static const routeName = '/zeltScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zelte'),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton:
          CustomFloatingButton(icon: Icons.add, pressAction: (ctx) {}),
      body: ZelteList(zeltList: [], editAction: (int i) {}),
    );
  }
}
