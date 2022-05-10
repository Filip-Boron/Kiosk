import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';

class KinderFormDialog extends StatelessWidget {
  KinderFormDialog({Key? key, required this.kind}) : super(key: key);

  Kind kind;
  bool guthabenIsValid = true;

  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _guthabenController = TextEditingController();
  final TextEditingController _zeltController = TextEditingController();
  final TextEditingController _kommentarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Vorname',
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            cursorColor: Theme.of(context).colorScheme.secondary,
            controller: _vornameController,
            onChanged: (input) {
              kind.vorname = input;
            },
            validator: (input) {
              if (input == null || input.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Der Vorname darf nicht leer sein.',
                );
              } else if (input.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                Fluttertoast.showToast(
                  msg: 'Der Nachname keine Sonderzeichen enthalten.',
                );
              }
            },
          ),
          const SizedBox(
            height: marginStandard,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nachname',
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            cursorColor: Theme.of(context).colorScheme.secondary,
            controller: _nachnameController,
            onChanged: (input) {
              kind.nachname = input;
            },
            validator: (input) {
              if (input == null || input.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Der Nachname darf nicht leer sein.',
                );
              } else if (input.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                return 'Der Nachname darf keine Sonderzeichen enthalten.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: marginStandard,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Guthaben',
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            cursorColor: Theme.of(context).colorScheme.secondary,
            onChanged: (input) {
              if (input.isEmpty) {
                kind.guthaben = null;
              } else if (double.tryParse(input) == null) {
                Fluttertoast.showToast(
                  msg: 'Das Guthaben darf nur aus Zahlen bestehen.',
                  toastLength: Toast.LENGTH_SHORT,
                );
                kind.guthaben = -1;
                return;
              }
              kind.guthaben = double.parse(input);
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: marginStandard,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Guthaben',
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            hint: const Text('Zelt auswählen'),
            items: context
                .read<ZelteCubit>()
                .state
                .zelteList
                .map<DropdownMenuItem<Zelt>>((Zelt zelt) {
              return DropdownMenuItem(
                value: zelt,
                child: Text(zelt.bezeichnung),
              );
            }).toList(),
            onChanged: (Zelt? newValue) {
              if (newValue == null) {
                return;
              }
              kind.zelt = newValue;
            },
          ),
          const SizedBox(
            height: marginStandard,
          ),
          Container(
            width: 400,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Kommentar',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).colorScheme.secondary,
              minLines: 1,
              maxLines: null,
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.text,
              onChanged: (String input) {
                kind.kommentar = input;
              },
            ),
          ),
        ],
      ),
    );
  }
}
