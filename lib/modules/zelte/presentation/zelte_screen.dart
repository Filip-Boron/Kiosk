import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if (state.status.isLoaded || state.status.isEditing) {
            return ZelteList(
              zeltList: state.zelteList,
              action: context.read<ZelteCubit>().editAction,
              icon: Icons.edit,
            );
          } else if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
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
  }
}
