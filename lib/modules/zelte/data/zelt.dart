import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'zelt.g.dart';

@HiveType(typeId: 0)
class Zelt extends Equatable {
  Zelt({required this.nummer, this.kinderAnzahl = 0, required this.dbKey}) {
    bezeichnung = 'Zelt $nummer';
  }
  @HiveField(0)
  int nummer;
  @HiveField(1)
  String bezeichnung = '';
  @HiveField(2)
  int kinderAnzahl;
  @HiveField(3)
  String dbKey;

  void addKind() {
    kinderAnzahl++;
  }

  void subKind() {
    if (kinderAnzahl == 0) {
      return;
    }
    kinderAnzahl--;
  }

  void setZeltnummer(int zeltnummer) {
    nummer = zeltnummer;
    bezeichnung = 'Zelt $nummer';
  }

  static Zelt copy(Zelt zelt) {
    return Zelt(
      nummer: zelt.nummer,
      kinderAnzahl: zelt.kinderAnzahl,
      dbKey: zelt.dbKey,
    );
  }

  @override
  List<Object?> get props => [nummer];
}
