// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_grid.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_kinder_cubit.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_kinder_state.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

class KioskKinderScrren extends StatelessWidget {
  const KioskKinderScrren({Key? key}) : super(key: key);

  static const routeName = '/kioskKinderScreen';

  @override
  Widget build(BuildContext context) {
    final Zelt zelt = ModalRoute.of(context)?.settings.arguments as Zelt;

    return BlocProvider(
      create: (context) => KioskKinderCubit()..setZelt(zelt, context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(zelt.bezeichnung),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //context.read<KioskKinderCubit>().updateView();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocBuilder<KioskKinderCubit, KioskKinderState>(
          builder: (context, state) {
            if (state.status.isLoaded) {
              return KinderGrid(
                kinderList: state.kinderList,
                actionPrimary: context.read<KioskKinderCubit>().auswahlAction,
                actionSecondary: (index, context) {},
              );
            } else if (state.status.isEmpty) {
              return const Center(
                child: Text('keine Kinder in dem Zelt vorhanden.'),
              );
            } else {
              return const Center(
                child: Text('etwas ist schief gelaufen ..'),
              );
            }
          },
        ),
      ),
    );
  }
}
