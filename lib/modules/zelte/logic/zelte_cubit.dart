// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/logic/zelte_state.dart';
import 'package:kiosk/modules/zelte/presentation/widgets/zelt_dialog.dart';

class ZelteCubit extends Cubit<ZelteState> {
  ZelteCubit() : super(ZelteInitial(zelteList: []));

  Future<bool> fetchData() async {
    emit(
      ZelteLoading(zelteList: state.zelteList),
    );

    //Fetch Data from Hive

    emit(
      ZelteLoaded(zelteList: state.zelteList),
    );
    return true;
  }

  Future addAction(BuildContext context) async {
    emit(
      ZelteEditing(zelteList: state.zelteList),
    );

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

    if (zelt != null) {
      state.zelteList.add(zelt);
    }
    emit(
      ZelteLoaded(zelteList: state.zelteList),
    );
  }

  Future editAction(int index, BuildContext context) async {
    emit(
      ZelteEditing(zelteList: state.zelteList),
    );

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

    if (zelt == null) {
      state.zelteList[index] = Zelt.copy(editZelt);
    }
    emit(
      ZelteLoaded(zelteList: state.zelteList),
    );
  }
}
