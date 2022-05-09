import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

class ZeltDialog extends StatelessWidget {
  ZeltDialog({Key? key, required this.titel, required this.zelt})
      : super(key: key) {
    if (zelt.nummer != 0) {
      _controller.text = zelt.nummer.toString();
    }
  }

  Zelt zelt;
  final String titel;
  int? zeltnummer;
  TextEditingController _controller = TextEditingController();
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
            color: Colors.grey.withOpacity(0.83),
            thickness: 1,
          ),
          const SizedBox(
            height: marginStandard,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'Zeltnummer : ',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  controller: _controller,
                  onChanged: (String input) {
                    if (input.isEmpty) {
                      zeltnummer = null;
                      return;
                    }
                    if (int.tryParse(input) != null) {
                      zeltnummer = int.parse(input);
                    } else {
                      Fluttertoast.showToast(msg: 'Bitte nur Zahlen eingeben.');
                      zeltnummer = null;
                    }
                  },
                ),
              ),
            ],
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
            if (zeltnummer == null) {
              Fluttertoast.showToast(
                msg: 'Bitte geben Sie eine gültige Nummer ein.',
              );
              return;
            }
            zelt.setZeltnummer(zeltnummer!);
            Navigator.pop(context, zelt);
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
