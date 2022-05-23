import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_form_dialog.dart';

class KinderDialog extends StatelessWidget {
  KinderDialog({Key? key, required this.titel, required this.kind})
      : super(key: key);

  final String titel;
  Kind kind;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(
        left: paddingStandard * 6,
        top: paddingStandard,
        right: paddingStandard * 6,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: paddingStandard),
      actionsPadding:
          const EdgeInsets.only(top: paddingStandard, right: paddingStandard),
      title: Text(
        titel,
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.83),
            thickness: 1,
          ),
          const SizedBox(
            height: marginStandard,
          ),
          KinderFormDialog(
            kind: kind,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Abbrechen',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () => Navigator.pop(context, null),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () {
            if (kind.vorname.isEmpty || kind.nachname.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Vorname und Nachname müssen ausgefüllt sein.',
                  toastLength: Toast.LENGTH_LONG);
              return;
            }
            if (kind.guthaben != null) {
              if (kind.guthaben == -1) {
                Fluttertoast.showToast(
                    msg: 'Ungültiges Guthaben.',
                    toastLength: Toast.LENGTH_LONG);
                return;
              }
            }
            Navigator.pop(context, kind);
          },
          child: Text(
            'BESTÄTIGEN',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}
