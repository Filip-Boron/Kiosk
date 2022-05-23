import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

class ZeltRepository {
  ZeltRepository.initial() : zeltBox = Hive.box('zelteBox');

  final Box<Zelt> zeltBox;

  void add(Zelt zelt) {
    zeltBox.put(zelt.dbKey, zelt);
  }

  void edit(Zelt zelt) {
    zeltBox.put(zelt.dbKey, zelt);
  }

  List<Zelt> getAllData() {
    return zeltBox.values.toList();
  }

  void delete(Zelt zelt) {
    zeltBox.delete(zelt.dbKey);
  }

  void clearData() {
    zeltBox.clear();
  }
}
