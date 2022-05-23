import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiosk/modules/kinder/data/kind.dart';

class KindRepository {
  KindRepository.initial() : kindBox = Hive.box('kindBox');

  final Box<Kind> kindBox;

  List<Kind> getAllData() {
    return kindBox.values.toList();
  }

  void add(Kind kind) {
    kindBox.put(kind.dbkey, kind);
  }

  void edit(Kind kind) {
    kindBox.put(kind.dbkey, kind);
  }

  void delete(Kind kind) {
    kindBox.delete(kind.dbkey);
  }

  void clearData() {
    kindBox.clear();
  }
}
