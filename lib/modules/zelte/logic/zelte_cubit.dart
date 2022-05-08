import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/modules/zelte/logic/zelte_state.dart';

class ZelteCubit extends Cubit<ZelteState> {
  ZelteCubit() : super(ZelteInitial());
}
