import 'package:equatable/equatable.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';

abstract class KinderState extends Equatable {
  KinderState({required this.kinderList});

  List<Kind> kinderList;
  @override
  List<Object?> get props => [
        kinderList,
      ];
}

class KinderInitial extends KinderState {
  KinderInitial({required List<Kind> kinderList})
      : super(kinderList: kinderList);
}

class KinderLoading extends KinderState {
  KinderLoading({required List<Kind> kinderList})
      : super(kinderList: kinderList);
}

class KinderLoaded extends KinderState {
  KinderLoaded({required List<Kind> kinderList})
      : super(kinderList: kinderList);
}

class KinderEditing extends KinderState {
  KinderEditing({required List<Kind> kinderList})
      : super(kinderList: kinderList);
}
