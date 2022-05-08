// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

abstract class ZelteState extends Equatable {
  ZelteState({required this.zelteList});

  List<Zelt> zelteList;

  @override
  List<Object?> get props => [
        zelteList,
      ];
}

class ZelteInitial extends ZelteState {
  ZelteInitial({List<Zelt> zelteList = const []}) : super(zelteList: zelteList);
}

class ZelteLoading extends ZelteState {
  ZelteLoading({required List<Zelt> zelteList}) : super(zelteList: zelteList);
}

class ZelteLoaded extends ZelteState {
  ZelteLoaded({required List<Zelt> zelteList}) : super(zelteList: zelteList);
}

class ZelteEditing extends ZelteState {
  ZelteEditing({required List<Zelt> zelteList}) : super(zelteList: zelteList);
}
