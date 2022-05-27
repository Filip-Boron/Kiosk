import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/constants/app_constants.dart';

class ShopBetrag extends StatelessWidget {
  const ShopBetrag({
    Key? key,
    required this.betragList,
    required this.subController,
  }) : super(key: key);

  final List<double> betragList;
  final TextEditingController subController;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(paddingStandard),
      itemCount: betragList.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width / 6,
        mainAxisExtent:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height / 6
                : MediaQuery.of(context).size.height / 4,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(paddingStandard),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Text(
              betragList[index].toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            onPressed: () {
              double textdouble = 0;
              if (subController.text.isEmpty) {
                textdouble += betragList[index];
                subController.text = textdouble.toString();
                return;
              } else if (double.tryParse(subController.text) == null) {
                Fluttertoast.showToast(
                    msg: 'Fehler bei der Umwandlung',
                    toastLength: Toast.LENGTH_LONG);
                return;
              }
              textdouble = double.parse(subController.text);
              textdouble += betragList[index];
              subController.text = textdouble.toStringAsFixed(2);
            },
          ),
        );
      },
    );
  }
}
