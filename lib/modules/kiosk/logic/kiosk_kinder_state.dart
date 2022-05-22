import 'package:equatable/equatable.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

enum KioskKinderStatus { inital, loading, loaded, empty }

extension KioskKinderStatusX on KioskKinderStatus {
  bool get isInitial => this == KioskKinderStatus.inital;
  bool get isLoading => this == KioskKinderStatus.loading;
  bool get isLoaded => this == KioskKinderStatus.loaded;
  bool get isEmpty => this == KioskKinderStatus.empty;
}

class KioskKinderState extends Equatable {
  const KioskKinderState({
    required this.status,
    required this.zelt,
    required this.kinderList,
  });
  const KioskKinderState.initial()
      : status = KioskKinderStatus.inital,
        zelt = null,
        kinderList = const [];

  final KioskKinderStatus status;
  final Zelt? zelt;
  final List<Kind> kinderList;

  KioskKinderState copyWith({
    KioskKinderStatus? status,
    Zelt? zelt,
    List<Kind>? kinderList,
  }) {
    return KioskKinderState(
        status: status ?? this.status,
        zelt: zelt ?? this.zelt,
        kinderList: kinderList ?? this.kinderList);
  }

  @override
  List<Object?> get props => [status];
}
