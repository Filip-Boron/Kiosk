import 'package:flutter/material.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';

class KioskShopScreen extends StatelessWidget {
  const KioskShopScreen({Key? key}) : super(key: key);

  static const routeName = '/KioskShopScreen';

  @override
  Widget build(BuildContext context) {
    final Kind kind = ModalRoute.of(context)?.settings.arguments as Kind;

    return Scaffold(
      appBar: AppBar(
        title: Text('${kind.vorname}  ${kind.nachname}'),
      ),
      body: Container(),
    );
  }
}
