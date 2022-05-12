// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kinder/logic/kinder_state.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_dialog.dart';

class KinderCubit extends Cubit<KinderState> {
  KinderCubit() : super(KinderInitial(kinderList: []));

  Future<bool> fetchData() async {
    emit(KinderLoading(kinderList: state.kinderList));

    //Fetch Data from Hive

    emit(KinderLoaded(kinderList: state.kinderList));
    return true;
  }

  Future addAction(BuildContext context) async {
    emit(KinderEditing(kinderList: state.kinderList));

    final Kind? kind = await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) {
        return KinderDialog(titel: 'Kind hinzufügen');
      },
    );

    if (kind != null) {
      state.kinderList.add(kind);
      kind.zelt?.addKind();
    }
    emit(KinderLoaded(kinderList: state.kinderList));
  }

  Future editAction(int index, BuildContext context) async {
    emit(KinderEditing(kinderList: state.kinderList));

    final Kind? editKind = await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) {
        return KinderDialog(
          titel: 'Kind bearbeiten',
          kind: Kind.copy(state.kinderList[index]),
        );
      },
    );

    if (editKind != null) {
      if (editKind.zelt != state.kinderList[index].zelt) {
        state.kinderList[index].zelt?.subKind();
        editKind.zelt?.addKind();
      }

      state.kinderList[index] = Kind.copy(editKind);
    }

    emit(KinderLoaded(kinderList: state.kinderList));
  }
}
