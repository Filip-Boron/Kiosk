import 'package:flutter/material.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

class ZelteList extends StatelessWidget {
  const ZelteList({
    Key? key,
    required this.zeltList,
    required this.action,
    required this.icon,
  }) : super(key: key);

  final List<Zelt> zeltList;
  final Function(int, BuildContext) action;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: marginStandard,
            vertical: 8,
          ),
          elevation: 4,
          child: ListTile(
            horizontalTitleGap: marginStandard,
            leading: Icon(
              zeltIcon,
              color: Theme.of(context).colorScheme.secondary,
              size: iconSizeStandard,
            ),
            title: Text(
              zeltList[index].bezeichnung,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Anzahl der Kinder: ${zeltList[index].kinderAnzahl}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: IconButton(
              icon: Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
                size: iconSizeStandard,
              ),
              onPressed: () {
                action(index, context);
              },
            ),
          ),
        );
      },
      itemCount: zeltList.length,
    );
  }
}
