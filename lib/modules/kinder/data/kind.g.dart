// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kind.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KindAdapter extends TypeAdapter<Kind> {
  @override
  final int typeId = 1;

  @override
  Kind read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kind(
      vorname: fields[0] as String,
      nachname: fields[1] as String,
      zelt: fields[2] as Zelt?,
      guthaben: fields[3] as double?,
      kommentar: fields[4] as String?,
      dbkey: fields[5] as String,
      lastVisit: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Kind obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.vorname)
      ..writeByte(1)
      ..write(obj.nachname)
      ..writeByte(2)
      ..write(obj.zelt)
      ..writeByte(3)
      ..write(obj.guthaben)
      ..writeByte(4)
      ..write(obj.kommentar)
      ..writeByte(5)
      ..write(obj.dbkey)
      ..writeByte(6)
      ..write(obj.lastVisit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KindAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
