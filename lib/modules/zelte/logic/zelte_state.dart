// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

enum ZelteStatus { initial, loading, loaded, editing, empty }

extension ZelteStatusX on ZelteStatus {
  bool get isInitial => this == ZelteStatus.initial;
  bool get isLoading => this == ZelteStatus.loading;
  bool get isLoaded => this == ZelteStatus.loaded;
  bool get isEditing => this == ZelteStatus.editing;
  bool get isEmpty => this == ZelteStatus.empty;
}

class ZelteState extends Equatable {
  const ZelteState({required this.zelteList, required this.status});
  const ZelteState.initial()
      : zelteList = const [],
        status = ZelteStatus.initial;

  final List<Zelt> zelteList;
  final ZelteStatus status;

  ZelteState copyWith({
    List<Zelt>? zelteList,
    ZelteStatus? status,
  }) {
    return ZelteState(
      zelteList: zelteList ?? this.zelteList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        zelteList,
        status,
      ];
}
