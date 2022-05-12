import 'dart:convert';

import 'package:kiosk/modules/zelte/data/zelt.dart';

class Kind {
  Kind({
    required this.vorname,
    required this.nachname,
    this.zelt,
    this.guthaben,
    this.kommentar,
  });
  String vorname;
  String nachname;
  Zelt? zelt;
  double? guthaben;
  String? kommentar;

  void setZelt(Zelt zelt) {
    this.zelt = Zelt(nummer: zelt.nummer, kinderAnzahl: zelt.kinderAnzahl);
  }

  static Kind copy(Kind kind) {
    return Kind(
        vorname: kind.vorname,
        nachname: kind.nachname,
        guthaben: kind.guthaben,
        kommentar: kind.kommentar,
        zelt: kind.zelt);
  }

  static Kind fromJson(Map<String, dynamic> json) {
    return Kind(
      vorname: json['vorname'] as String,
      nachname: json['nachname'] as String,
      zelt: json['zelt'] as Zelt,
      guthaben: json['guthaben'] as double,
      kommentar: json['kommentar'] as String,
    );
  }

  String toJson() {
    return jsonEncode({
      'vorname': vorname,
      'nachname': nachname,
      'zelt': zelt,
      'guthaben': guthaben,
      'kommentar': kommentar,
    });
  }
}
