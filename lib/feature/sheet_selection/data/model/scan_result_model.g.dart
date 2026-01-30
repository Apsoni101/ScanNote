// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScanResultModelAdapter extends TypeAdapter<ScanResultModel> {
  @override
  final int typeId = 1;

  @override
  ScanResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ScanResultModel(
      data: fields[0] as String,
      comment: fields[1] as String,
      timestamp: fields[2] as DateTime,
      deviceId: fields[3] as String?,
      userId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScanResultModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.deviceId)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
