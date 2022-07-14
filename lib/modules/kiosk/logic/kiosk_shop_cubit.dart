// ignore_for_file: omit_local_variable_types
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/kinder/data/kind_repository.dart';
import 'package:kiosk/modules/kiosk/logic/kiosk_shop_state.dart';
import 'package:intl/intl.dart';

class KioskShopCubit extends Cubit<KioskShopState> {
  KioskShopCubit() : super(const KioskShopState.initial());

  void setKind(Kind kind) {
    emit(state.copyWith(status: KioskShopStatus.loaded, kind: kind));
  }

  void subGuthaben(String input, BuildContext context) {
    if (input.isEmpty) {
      Fluttertoast.showToast(msg: 'Betrag darf nicht leer sein.');
      return;
    }
    if (double.tryParse(input) == null) {
      Fluttertoast.showToast(
        msg: 'Der Betrag darf nur aus Zahlen und einem Punkt bestehen.',
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }
    emit(state.copyWith(status: KioskShopStatus.editing));
    try {
      final double doubleInput = double.parse(input);

      final Kind? kind = state.kind;

      if (kind == null) {
        Fluttertoast.showToast(
          msg: 'etwas ist schief gelaufen.',
          toastLength: Toast.LENGTH_SHORT,
        );
        return;
      }

      kind.guthaben = kind.guthaben! - doubleInput;
      kind.lastVisit = DateFormat('dd.MM.y - HH:mm').format(DateTime.now());

      context.read<KindRepository>().edit(kind);
      emit(state.copyWith(status: KioskShopStatus.loaded, kind: kind));
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Fehler beim Aktualisieren des Guthabens.',
        toastLength: Toast.LENGTH_SHORT,
      );
      emit(state.copyWith(status: KioskShopStatus.loaded));
    }
  }

  void addGuthaben(String input, BuildContext context) {
    if (input.isEmpty) {
      Fluttertoast.showToast(msg: 'Betrag darf nicht leer sein.');
      return;
    }
    if (double.tryParse(input) == null) {
      Fluttertoast.showToast(
        msg: 'Der Betrag darf nur aus Zahlen und einem Punkt bestehen.',
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }
    emit(state.copyWith(status: KioskShopStatus.editing));
    try {
      final double doubleInput = double.parse(input);

      final Kind? kind = state.kind;

      if (kind == null) {
        Fluttertoast.showToast(
          msg: 'etwas ist schief gelaufen.',
          toastLength: Toast.LENGTH_SHORT,
        );
        return;
      }

      kind.guthaben = kind.guthaben! + doubleInput;

      context.read<KindRepository>().edit(kind);
      emit(state.copyWith(status: KioskShopStatus.loaded, kind: kind));
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Fehler beim Aktualisieren des Guthabens.',
        toastLength: Toast.LENGTH_SHORT,
      );
      emit(state.copyWith(status: KioskShopStatus.loaded));
    }
  }
}
