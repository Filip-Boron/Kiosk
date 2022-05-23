import 'package:equatable/equatable.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';

enum KinderStatus { initial, loading, loaded, editing, empty }

extension KinderStatusX on KinderStatus {
  bool get isInistial => this == KinderStatus.initial;
  bool get isLoading => this == KinderStatus.loading;
  bool get isLoaded => this == KinderStatus.loaded;
  bool get isEditing => this == KinderStatus.editing;
  bool get isEmpty => this == KinderStatus.empty;
}

class KinderState extends Equatable {
  const KinderState(
      {required this.kinderList, required this.status, required this.fullList});
  const KinderState.initial()
      : status = KinderStatus.initial,
        kinderList = const [],
        fullList = const [];

  final List<Kind> kinderList;
  final KinderStatus status;
  final List<Kind> fullList;

  KinderState copyWith(
      {List<Kind>? kinderList, KinderStatus? status, List<Kind>? fullList}) {
    return KinderState(
      kinderList: kinderList ?? this.kinderList,
      status: status ?? this.status,
      fullList: fullList ?? this.fullList,
    );
  }

  @override
  List<Object?> get props => [
        kinderList,
        status,
        fullList,
      ];
}
