import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/app/widgets/custom_floating_button.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';
import 'package:kiosk/modules/kinder/logic/kinder_state.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_grid.dart';

class KinderScreen extends StatelessWidget {
  const KinderScreen({Key? key}) : super(key: key);

  static const routeName = '/kinderScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kinder'),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFloatingButton(
        icon: Icons.add,
        pressAction: context.read<KinderCubit>().addAction,
      ),
      body: BlocBuilder<KinderCubit, KinderState>(
        builder: (context, state) {
          if (state is KinderLoaded || state is KinderEditing) {
            return KinderGrid(
              kinderList: state.kinderList,
              editAction: context.read<KinderCubit>().editAction,
            );
          } else if (state is KinderLoading) {
            return const Padding(
              padding: EdgeInsets.all(paddingStandard),
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('etwas ist schief gelaufen..'),
            );
          }
        },
      ),
    );
  }
}
