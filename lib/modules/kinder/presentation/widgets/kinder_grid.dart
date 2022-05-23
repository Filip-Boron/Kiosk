import 'package:flutter/material.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';

class KinderGrid extends StatelessWidget {
  const KinderGrid({
    Key? key,
    required this.kinderList,
    required this.actionPrimary,
    required this.actionSecondary,
  }) : super(key: key);

  final List<Kind> kinderList;
  final Function(int, BuildContext) actionPrimary;
  final Function(int, BuildContext) actionSecondary;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.only(top: paddingStandard),
        itemCount: kinderList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
          mainAxisExtent: (MediaQuery.of(context).size.height) / 6,
        ),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: marginStandard,
              vertical: 8,
            ),
            elevation: 4,
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, right: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            '${kinderList[index].vorname} ${kinderList[index].nachname}',
                            softWrap: true,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.83),
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.euro),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${kinderList[index].guthaben ?? ''}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: marginStandard,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        const Icon(zeltIcon),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${kinderList[index].zelt?.bezeichnung ?? ''}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                actionPrimary(index, context);
              },
              onLongPress: () {
                actionSecondary(index, context);
              },
            ),
          );
        },
      ),
    );
  }
}
