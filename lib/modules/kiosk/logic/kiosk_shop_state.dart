import 'package:equatable/equatable.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';

enum KioskShopStatus {
  initial,
  loaded,
  editing,
}

extension KioskShopStateX on KioskShopStatus {
  bool get isInitial => this == KioskShopStatus.initial;
  bool get isLoaded => this == KioskShopStatus.loaded;
  bool get isEditing => this == KioskShopStatus.editing;
}

class KioskShopState extends Equatable {
  const KioskShopState({required this.status, required this.kind});
  const KioskShopState.initial()
      : status = KioskShopStatus.initial,
        kind = null;

  final KioskShopStatus status;
  final Kind? kind;

  KioskShopState copyWith({KioskShopStatus? status, Kind? kind}) {
    return KioskShopState(
        status: status ?? this.status, kind: kind ?? this.kind);
  }

  @override
  List<Object?> get props => [status];
}
