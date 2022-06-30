import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';

class KinderFormDialog extends StatelessWidget {
  KinderFormDialog({Key? key, required this.kind}) : super(key: key) {
    _vornameController.text = kind.vorname;
    _nachnameController.text = kind.nachname;
    kind.guthaben == null
        ? _guthabenController.text = ''
        : _guthabenController.text = kind.guthaben!.toStringAsFixed(2);
    kind.zelt != null ? _zeltController = kind.zelt : _zeltController = null;

    _kommentarController.text = kind.kommentar ?? '';
  }

  Kind kind;
  bool guthabenIsValid = true;

  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _guthabenController = TextEditingController();
  Zelt? _zeltController;
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
            textCapitalization: TextCapitalization.sentences,
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
            textCapitalization: TextCapitalization.sentences,
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
            controller: _guthabenController,
            onChanged: (input) {
              if (input.isEmpty) {
                kind.guthaben = null;
                return;
              } else if (double.tryParse(input) == null) {
                Fluttertoast.showToast(
                  msg:
                      'Das Guthaben darf nur aus Zahlen oder einem Punkt bestehen.',
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
              labelText: 'Zelt',
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
            value: _zeltController,
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
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Anmerkung',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).colorScheme.secondary,
              controller: _kommentarController,
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
