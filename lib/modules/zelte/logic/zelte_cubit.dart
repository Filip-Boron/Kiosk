// ignore_for_file: omit_local_variable_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/modules/app/widgets/c_alter_dialog.dart';
import 'package:kiosk/modules/kinder/data/kind_repository.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_cubit.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/data/zelt_repository.dart';
import 'package:kiosk/modules/zelte/logic/zelte_state.dart';
import 'package:kiosk/modules/zelte/presentation/widgets/zelt_dialog.dart';

class ZelteCubit extends Cubit<ZelteState> {
  ZelteCubit() : super(const ZelteState.initial());

  Future<bool> fetchData(BuildContext context) async {
    emit(state.copyWith(status: ZelteStatus.loading));
    context.read<KioskCubit>().dataIsLoading();

    //Fetch Data from Hive
    List<Zelt> zelteList = context.read<ZeltRepository>().getAllData();

    if (zelteList.isEmpty) {
      emit(state.copyWith(status: ZelteStatus.empty, zelteList: []));
      context.read<KioskCubit>().dataIsEmpty();
      return true;
    }

    emit(state.copyWith(status: ZelteStatus.loaded, zelteList: zelteList));
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
          zelt: Zelt(nummer: -1, dbKey: UniqueKey().toString()),
        );
      },
    );
    List<Zelt>? zelteList;
    if (zelt != null) {
      zelteList = [...state.zelteList];
      zelteList.add(zelt);

      context.read<ZeltRepository>().add(zelt);
    }
    emit(
      state.copyWith(status: ZelteStatus.loaded, zelteList: zelteList),
    );
    context.read<KioskCubit>().dataLoaded();
  }

  Future editAction(int index, BuildContext context) async {
    emit(state.copyWith(status: ZelteStatus.editing));

    final Zelt oldZelt = Zelt.copy(state.zelteList[index]);

    final Zelt? editZelt = await showDialog<Zelt>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ZeltDialog(
          titel: 'Zelt bearbeiten',
          zelt: Zelt.copy(state.zelteList[index]),
        );
      },
    );

    if (editZelt == null || editZelt.nummer == oldZelt.nummer) {
      emit(
        state.copyWith(
          status: ZelteStatus.loaded,
        ),
      );
      return;
    }

    final List<Zelt> zelteList = state.zelteList;

    zelteList[index] = editZelt;
    context.read<ZeltRepository>().edit(editZelt);
    context
        .read<KinderCubit>()
        .editZelt(oldZelt: oldZelt, newZelt: editZelt, context: context);

    emit(state.copyWith(status: ZelteStatus.loaded, zelteList: zelteList));
  }

  Zelt getZeltByIndex(int index) {
    return state.zelteList[index];
  }

  void subZelt(int zeltNummer, BuildContext context) {
    try {
      final Zelt zelt = state.zelteList
          .where((element) => element.nummer == zeltNummer)
          .first;

      zelt.subKind();
      context.read<ZeltRepository>().edit(zelt);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Fehler bei der Aktualisierung.',
          toastLength: Toast.LENGTH_LONG);
    }
  }

  void addZelt(int zeltNummer, BuildContext context) {
    try {
      final Zelt zelt = state.zelteList
          .where((element) => element.nummer == zeltNummer)
          .first;

      zelt.addKind();
      context.read<ZeltRepository>().edit(zelt);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Fehler bei der Aktualisierung.',
          toastLength: Toast.LENGTH_LONG);
    }
  }

  Future deleteAction(int index, BuildContext context) async {
    final bool? reponse = await _showDeleteDialog(context);

    if (reponse == false) {
      return;
    }
    emit(state.copyWith(status: ZelteStatus.editing));

    final List<Zelt> zelteList = state.zelteList;
    final Zelt zelt = zelteList[index];

    context.read<ZeltRepository>().delete(zelt);

    zelteList.removeAt(index);
    context.read<KinderCubit>().removeZelt(zelt, context);
    emit(state.copyWith(status: ZelteStatus.loaded, zelteList: zelteList));
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return CAltertDialog(
            context: ctx,
            titel: 'Zelt löschen',
            content: 'möchtest du das Zelt wirklich löschen?',
          );
        });
  }
}
