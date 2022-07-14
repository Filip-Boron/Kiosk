import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_shop_cubit.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_shop_state.dart';

class ShopKinderInfo extends StatelessWidget {
  const ShopKinderInfo({Key? key, required this.kind}) : super(key: key);

  final Kind kind;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(
              Icons.euro,
              size: iconSizeStandard,
            ),
            const SizedBox(width: marginStandard / 2),
            BlocBuilder<KioskShopCubit, KioskShopState>(
              builder: (context, state) {
                return Expanded(
                  child: Row(
                    children: [
                      Text(
                        kind.guthaben?.toStringAsFixed(2) ?? '',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const Spacer(),
                      Text(
                        kind.lastVisit ?? '',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: marginStandard),
        Row(
          children: [
            const Icon(
              Icons.comment,
              size: iconSizeStandard,
            ),
            const SizedBox(width: marginStandard / 2),
            Expanded(
              child: Text(
                kind.kommentar ?? '',
                style: Theme.of(context).textTheme.headline6,
                softWrap: true,
              ),
            ),
          ],
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.83),
          thickness: 1.5,
        ),
      ],
    );
  }
}
