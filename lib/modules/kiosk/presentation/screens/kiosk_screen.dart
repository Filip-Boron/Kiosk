import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_cubit.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_state.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';
import 'package:kiosk/modules/zelte/logic/zelte_state.dart';
import 'package:kiosk/modules/zelte/presentation/widgets/zelte_list.dart';

class KioskScreen extends StatelessWidget {
  const KioskScreen({Key? key}) : super(key: key);

  static const routeName = '/kioskScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KioskCubit, KioskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kiosk'),
          ),
          drawer: const CustomDrawer(),
          body: BlocBuilder<KioskCubit, KioskState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status.isLoaded) {
                return ZelteList(
                  icon: Icons.arrow_forward,
                  zeltList: context.read<ZelteCubit>().state.zelteList,
                  action: context.read<KioskCubit>().auswahlAction,
                );
              } else if (state.status.isEmpty) {
                return const Center(
                  child: Text('keine Zelte vorhanden.'),
                );
              } else {
                return const Center(
                  child: Text('etwas ist schief gelaufen ..'),
                );
              }
            },
          ),
        );
      },
    );
  }
}
