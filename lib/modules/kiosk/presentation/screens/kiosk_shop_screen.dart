import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_shop_cubit.dart';
import 'package:kiosk/modules/kiosk/presentation/widgets/shop_input.dart';
import 'package:kiosk/modules/kiosk/presentation/widgets/shop_kinder_info.dart';

class KioskShopScreen extends StatelessWidget {
  const KioskShopScreen({Key? key}) : super(key: key);

  static const routeName = '/KioskShopScreen';

  @override
  Widget build(BuildContext context) {
    final Kind kind = ModalRoute.of(context)?.settings.arguments as Kind;

    return BlocProvider(
      create: (context) => KioskShopCubit()..setKind(kind),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${kind.vorname}  ${kind.nachname}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //context.read<KioskKinderCubit>().updateView();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(paddingStandard),
          child: Column(
            children: [
              ShopKinderInfo(kind: kind),
              const SizedBox(height: marginStandard * 2),
              ShopInput(),
            ],
          ),
        ),
      ),
    );
  }
}
