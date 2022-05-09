import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/app/widgets/custom_floating_button.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';
import 'package:kiosk/modules/zelte/logic/zelte_state.dart';
import 'package:kiosk/modules/zelte/presentation/widgets/zelte_list.dart';

class ZelteScreen extends StatelessWidget {
  const ZelteScreen({Key? key}) : super(key: key);

  static const routeName = '/zeltScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zelte'),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFloatingButton(
        icon: Icons.add,
        pressAction: context.read<ZelteCubit>().addAction,
      ),
      body: BlocBuilder<ZelteCubit, ZelteState>(
        builder: (context, state) {
          if (state is ZelteLoaded || state is ZelteEditing) {
            return ZelteList(
              zeltList: state.zelteList,
              editAction: context.read<ZelteCubit>().editAction,
            );
          } else if (state is ZelteLoading) {
            return const Padding(
              padding: EdgeInsets.all(paddingStandard),
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('etwas ist schief gelaufen ..'),
            );
          }
        },
      ),
    );
  }
}
