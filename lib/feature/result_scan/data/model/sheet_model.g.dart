// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SheetModelAdapter extends TypeAdapter<SheetModel> {
  @override
  final int typeId = 2;

  @override
  SheetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return SheetModel(
      id: fields[0] as String,
      title: fields[1] as String,
      createdTime: fields[2] as String?,
      modifiedTime: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SheetModel obj) {
    writer
      ..writeByte(4) // number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.createdTime)
      ..writeByte(3)
      ..write(obj.modifiedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SheetModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
