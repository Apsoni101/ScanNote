// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_scan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultScanModelAdapter extends TypeAdapter<ResultScanModel> {
  @override
  final int typeId = 1;

  @override
  ResultScanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ResultScanModel(
      data: fields[0] as String,
      comment: fields[1] as String,
      timestamp: fields[2] as DateTime,
      deviceId: fields[3] as String?,
      userId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultScanModel obj) {
    writer
      ..writeByte(5) // number of fields
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
          other is ResultScanModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
