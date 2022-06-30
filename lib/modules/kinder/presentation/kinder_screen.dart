import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/app/widgets/custom_floating_button.dart';
import 'package:kiosk/modules/drawer/custom_drawer.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';
import 'package:kiosk/modules/kinder/logic/kinder_state.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_grid.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_searchbar.dart';

class KinderScreen extends StatelessWidget {
  const KinderScreen({Key? key}) : super(key: key);

  static const routeName = '/kinderScreen';

  @override
  Widget build(BuildContext context) {
    context.read<KinderCubit>().setFullList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kinder'),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFloatingButton(
        icon: Icons.add,
        pressAction: context.read<KinderCubit>().addAction,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KinderSearchbar(),
          BlocBuilder<KinderCubit, KinderState>(
            builder: (context, state) {
              if (state.status.isLoaded || state.status.isEditing) {
                return Expanded(
                  child: KinderGrid(
                    kinderList: state.kinderList,
                    actionPrimary: context.read<KinderCubit>().editAction,
                    actionSecondary: context.read<KinderCubit>().deleteAction,
                  ),
                );
              } else if (state.status.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status.isEmpty) {
                return const Center(
                  child: Text('keine Kinder vorhanden.'),
                );
              } else {
                return const Center(
                  child: Text('etwas ist schief gelaufen..'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
