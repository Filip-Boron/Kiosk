// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/modules/app/widgets/c_alter_dialog.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';
import 'package:kiosk/modules/kinder/data/kind_repository.dart';
import 'package:kiosk/modules/zelte/data/zelt_repository.dart';

class StettingsScreen extends StatelessWidget {
  const StettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final bool? response = await _showDeleteDialog(context);

            if (response == false) {
              return;
            }
            context.read<ZeltRepository>().clearData();
            context.read<KindRepository>().clearData();
            await Fluttertoast.showToast(
                msg: 'Daten wurden erfolgreich gelöscht.',
                toastLength: Toast.LENGTH_LONG);
          },
          child: const Text('Daten löschen'),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return CAltertDialog(
            context: ctx,
            titel: 'Daten löschen',
            content: 'Alle Daten werden unwiderruflich gelöscht.',
          );
        });
  }
}
