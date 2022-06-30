import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_kinder_state.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_shop_screen.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

class KioskKinderCubit extends Cubit<KioskKinderState> {
  KioskKinderCubit() : super(const KioskKinderState.initial());

  void setZelt(Zelt zelt, BuildContext context) {
    List<Kind> kinderList = context
        .read<KinderCubit>()
        .state
        .fullList
        .where((element) => element.zelt?.nummer == zelt.nummer)
        .toList();

    if (kinderList.isEmpty) {
      emit(state.copyWith(
        status: KioskKinderStatus.empty,
        zelt: zelt,
        kinderList: [],
      ));
      return;
    }

    // ignore: omit_local_variable_types
    /* List<Kind> kinderList = context
        .read<KinderCubit>()
        .state
        .kinderList
        .where((kind) => kind.zelt?.nummer == zelt.nummer)
        .toList(); */

    emit(state.copyWith(
      status: KioskKinderStatus.loaded,
      zelt: zelt,
      kinderList: kinderList,
    ));
  }

  void updateView() {
    emit(state.copyWith(status: KioskKinderStatus.loading));
    emit(state.copyWith(status: KioskKinderStatus.loaded));
  }

  Future auswahlAction(int index, BuildContext context) async {
    await Navigator.of(context)
        .pushNamed(
          KioskShopScreen.routeName,
          arguments: state.kinderList[index],
        )
        .then(
          (value) => updateView(),
        );
  }
}
