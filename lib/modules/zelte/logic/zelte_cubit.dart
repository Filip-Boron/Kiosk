// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_cubit.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/logic/zelte_state.dart';
import 'package:kiosk/modules/zelte/presentation/widgets/zelt_dialog.dart';

class ZelteCubit extends Cubit<ZelteState> {
  ZelteCubit() : super(const ZelteState.initial());

  Future<bool> fetchData(BuildContext context) async {
    emit(state.copyWith(status: ZelteStatus.loading));
    context.read<KioskCubit>().dataIsLoading();

    //Fetch Data from Hive

    List<Zelt> zelteList = [];

    if (zelteList.isEmpty) {
      emit(state.copyWith(status: ZelteStatus.empty, zelteList: []));
      context.read<KioskCubit>().dataIsEmpty();
      return true;
    }

    emit(state.copyWith(status: ZelteStatus.loaded, zelteList: []));
    context.read<KioskCubit>().dataLoaded();
    return true;
  }

  Future addAction(BuildContext context) async {
    emit(state.copyWith(status: ZelteStatus.editing));

    final Zelt? zelt = await showDialog<Zelt>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ZeltDialog(
          titel: 'Zelt hinzufügen',
          zelt: Zelt(nummer: 0),
        );
      },
    );
    List<Zelt>? zelteList;
    if (zelt != null) {
      zelteList = [...state.zelteList];
      zelteList.add(zelt);
    }
    emit(
      state.copyWith(status: ZelteStatus.loaded, zelteList: zelteList),
    );
    context.read<KioskCubit>().dataLoaded();
  }

  Future editAction(int index, BuildContext context) async {
    emit(state.copyWith(status: ZelteStatus.editing));

    final Zelt editZelt = Zelt.copy(state.zelteList[index]);

    final Zelt? zelt = await showDialog<Zelt>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ZeltDialog(
          titel: 'Zelt hinzufügen',
          zelt: state.zelteList[index],
        );
      },
    );

    List<Zelt>? zelteList;
    if (zelt == null) {
      zelteList = [...state.zelteList];
      zelteList[index] = Zelt.copy(editZelt);
    }
    emit(state.copyWith(status: ZelteStatus.loaded, zelteList: zelteList));
  }

  Zelt getZeltByIndex(int index) {
    return state.zelteList[index];
  }
}
