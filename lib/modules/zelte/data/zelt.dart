import 'dart:convert';

class Zelt {
  Zelt({required this.nummer, this.kinderAnzahl = 0}) {
    bezeichnung = 'Zelt $nummer';
  }

  final int nummer;
  String bezeichnung = '';
  int kinderAnzahl;

  void addKind() {
    kinderAnzahl++;
  }

  void subKind() {
    if (kinderAnzahl == 0) {
      return;
    }
    kinderAnzahl--;
  }

  static Zelt fromJson(Map<String, dynamic> json) {
    return Zelt(
      nummer: json['nummer'] as int,
      kinderAnzahl: json['kinderAnzahl'] as int,
    );
  }

  String toJson() {
    return jsonEncode({
      'nummer': nummer,
      'kinderAnzahl': kinderAnzahl,
    });
  }
}
