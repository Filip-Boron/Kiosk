// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zelt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZeltAdapter extends TypeAdapter<Zelt> {
  @override
  final int typeId = 0;

  @override
  Zelt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Zelt(
      nummer: fields[0] as int,
      kinderAnzahl: fields[2] as int,
      dbKey: fields[3] as String,
    )..bezeichnung = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Zelt obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nummer)
      ..writeByte(1)
      ..write(obj.bezeichnung)
      ..writeByte(2)
      ..write(obj.kinderAnzahl)
      ..writeByte(3)
      ..write(obj.dbKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZeltAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
