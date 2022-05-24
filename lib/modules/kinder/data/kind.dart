import 'package:hive/hive.dart';
import 'package:kiosk/modules/zelte/data/zelt.dart';

part 'kind.g.dart';

@HiveType(typeId: 1)
class Kind {
  Kind({
    required this.vorname,
    required this.nachname,
    this.zelt,
    this.guthaben,
    this.kommentar,
    required this.dbkey,
  });
  @HiveField(0)
  String vorname;
  @HiveField(1)
  String nachname;
  @HiveField(2)
  Zelt? zelt;
  @HiveField(3)
  double? guthaben;
  @HiveField(4)
  String? kommentar;
  @HiveField(5)
  String dbkey;

  String get bezeichnung {
    return '$vorname $nachname';
  }

  static Kind copy(Kind kind) {
    return Kind(
      vorname: kind.vorname,
      nachname: kind.nachname,
      guthaben: kind.guthaben,
      kommentar: kind.kommentar,
      zelt: kind.zelt,
      dbkey: kind.dbkey,
    );
  }
}
