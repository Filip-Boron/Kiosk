import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_shop_cubit.dart';
import 'package:kiosk/modules/kiosk/presentation/widgets/shop_betrag.dart';

class ShopInput extends StatelessWidget {
  ShopInput({Key? key}) : super(key: key);

  final TextEditingController _subController = TextEditingController();
  final TextEditingController _addController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Betrag',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).colorScheme.secondary,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _subController,
                onChanged: (input) {
                  if (input.isEmpty) {
                    return;
                  }
                  if (double.tryParse(input) == null) {
                    Fluttertoast.showToast(
                      msg:
                          'Der Betrag darf nur aus Zahlen und einem Punkt bestehen.',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: marginStandard),
            FloatingActionButton(
              heroTag: 'btn1',
              child: const Icon(
                Icons.remove,
              ),
              onPressed: () {
                context
                    .read<KioskShopCubit>()
                    .subGuthaben(_subController.text, context);
                _subController.text = '';
              },
            ),
          ],
        ),
        const SizedBox(height: marginStandard * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Betrag',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).colorScheme.secondary,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _addController,
                onChanged: (input) {
                  if (input.isEmpty) {
                    return;
                  }
                  if (double.tryParse(input) == null) {
                    Fluttertoast.showToast(
                      msg:
                          'Der Betrag darf nur aus Zahlen und einem Punkt bestehen.',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: marginStandard),
            FloatingActionButton(
              heroTag: 'btn2',
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                context
                    .read<KioskShopCubit>()
                    .addGuthaben(_addController.text, context);
                _addController.text = '';
              },
            ),
          ],
        ),
        const SizedBox(
          height: marginStandard,
        ),
        Expanded(
          child: ShopBetrag(
            subController: _subController,
            betragList: betragList,
          ),
        ),
      ],
    );
  }
}
