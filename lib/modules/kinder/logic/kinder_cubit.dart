// ignore_for_file: omit_local_variable_types, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/app/widgets/c_alter_dialog.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kinder/data/kind_repository.dart';
import 'package:kiosk/modules/kinder/logic/kinder_state.dart';
import 'package:kiosk/modules/kinder/presentation/widgets/kinder_dialog.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';
import 'package:kiosk/modules/zelte/data/zelt_repository.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';

class KinderCubit extends Cubit<KinderState> {
  KinderCubit() : super(const KinderState.initial());

  Future<bool> fetchData(BuildContext context) async {
    emit(state.copyWith(status: KinderStatus.loading));

    //Fetch Data from Hive
    final List<Kind> kinderList = context.read<KindRepository>().getAllData();

    if (kinderList.isEmpty) {
      emit(state.copyWith(status: KinderStatus.empty, kinderList: []));
      return true;
    }

    emit(state.copyWith(status: KinderStatus.loaded, kinderList: kinderList));
    return true;
  }

  Future addAction(BuildContext context) async {
    emit(state.copyWith(status: KinderStatus.editing));

    Kind newKind =
        Kind(vorname: '', nachname: '', dbkey: UniqueKey().toString());
    final Kind? kind = await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) {
        return KinderDialog(
          titel: 'Kind hinzufügen',
          kind: newKind,
        );
      },
    );

    List<Kind>? kinderList;
    if (kind != null) {
      kinderList = [...state.kinderList];
      kinderList.add(kind);
      kind.zelt?.addKind();

      if (kind.zelt != null) {
        context.read<ZeltRepository>().edit(kind.zelt as Zelt);
      }
      context.read<KindRepository>().add(kind);
    }
    emit(state.copyWith(status: KinderStatus.loaded, kinderList: kinderList));
  }

  Future editAction(int index, BuildContext context) async {
    emit(state.copyWith(status: KinderStatus.editing));

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

    List<Kind>? kinderList;
    if (editKind != null) {
      kinderList = [...state.kinderList];
      if (editKind.zelt != kinderList[index].zelt) {
        if (kinderList[index].zelt != null) {
          context
              .read<ZelteCubit>()
              .subZelt(kinderList[index].zelt!.nummer, context);
        }

        if (editKind.zelt != null) {
          context.read<ZelteCubit>().addZelt(editKind.zelt!.nummer, context);
        }
      }

      kinderList[index] = Kind.copy(editKind);
      context.read<KindRepository>().edit(editKind);
    }

    emit(state.copyWith(status: KinderStatus.loaded, kinderList: kinderList));
  }

  Future deleteAction(int index, BuildContext context) async {
    final bool? response = await _showDeleteDialog(context);

    if (response == false) {
      return;
    }
    emit(state.copyWith(status: KinderStatus.editing));

    final List<Kind> kinderList = state.kinderList;

    final Kind kind = kinderList[index];

    context.read<KindRepository>().delete(kind);

    kinderList.removeAt(index);
    if (kind.zelt != null) {
      context.read<ZelteCubit>().subZelt(kind.zelt!.nummer, context);
    }

    emit(state.copyWith(status: KinderStatus.loaded, kinderList: kinderList));
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return CAltertDialog(
            context: ctx,
            titel: 'Kind löschen',
            content: 'möchtest du das Kind wirklich löschen?',
          );
        });
  }

  void removeZelt(Zelt zelt, BuildContext context) {
    final List<Kind> kinderList =
        state.kinderList.where((element) => element.zelt == zelt).toList();

    if (kinderList.isEmpty) {
      return;
    }

    kinderList.forEach((element) {
      element.zelt = null;
      context.read<KindRepository>().edit(element);
    });
  }

  void editZelt(
      {required Zelt oldZelt,
      required Zelt newZelt,
      required BuildContext context}) {
    final List<Kind> kinderList =
        state.kinderList.where((element) => element.zelt == oldZelt).toList();

    if (kinderList.isEmpty) {
      return;
    }

    kinderList.forEach((element) {
      element.zelt = newZelt;
      context.read<KindRepository>().edit(element);
    });
  }

  Kind getKindByIndex(int index) {
    return state.kinderList[index];
  }
}
