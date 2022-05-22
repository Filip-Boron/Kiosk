import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_state.dart';
import 'package:kiosk/modules/kiosk/presentation/screens/kiosk_kinder_screen.dart';
import 'package:kiosk/modules/zelte/logic/zelte_cubit.dart';

class KioskCubit extends Cubit<KioskState> {
  KioskCubit() : super(const KioskState.initial());

  void dataLoaded() {
    emit(state.copyWith(status: KioskStatus.loaded));
  }

  void dataIsEmpty() {
    emit(state.copyWith(status: KioskStatus.empty));
  }

  void dataIsLoading() {
    emit(state.copyWith(status: KioskStatus.loading));
  }

  Future auswahlAction(int index, BuildContext context) async {
    await Navigator.of(context).pushNamed(
      KioskKinderScrren.routeName,
      arguments: context.read<ZelteCubit>().getZeltByIndex(index),
    );
  }
}
