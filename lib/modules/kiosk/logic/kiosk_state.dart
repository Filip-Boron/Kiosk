import 'package:equatable/equatable.dart';

enum KioskStatus { initial, loading, loaded, empty }

extension KioskStatusX on KioskStatus {
  bool get isInitial => this == KioskStatus.initial;
  bool get isLoading => this == KioskStatus.loading;
  bool get isLoaded => this == KioskStatus.loaded;
  bool get isEmpty => this == KioskStatus.empty;
}

class KioskState extends Equatable {
  const KioskState({required this.status});
  const KioskState.initial() : status = KioskStatus.loaded;

  final KioskStatus status;

  KioskState copyWith({KioskStatus? status}) {
    return KioskState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
