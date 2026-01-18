// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_sync_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingSyncModelAdapter extends TypeAdapter<PendingSyncModel> {
  @override
  final int typeId = 3;

  @override
  PendingSyncModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return PendingSyncModel(
      scan: fields[0] as ResultScanModel,
      sheetId: fields[1] as String,
      sheetTitle: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PendingSyncModel obj) {
    writer
      ..writeByte(3) // number of fields
      ..writeByte(0)
      ..write(obj.scan)
      ..writeByte(1)
      ..write(obj.sheetId)
      ..writeByte(2)
      ..write(obj.sheetTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PendingSyncModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
