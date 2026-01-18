import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';

part 'sheet_model.g.dart';

@HiveType(typeId: 2)
class SheetModel extends SheetEntity {
  const SheetModel({
    @HiveField(0) required super.id,
    @HiveField(1) required super.title,
    @HiveField(2) super.createdTime,
    @HiveField(3) super.modifiedTime,
  });

  factory SheetModel.fromJson(final Map<String, dynamic> json) {
    return SheetModel(
      id: json['id']?.toString() ?? '',
      title: json['name']?.toString() ?? '',
      createdTime: json['createdTime']?.toString(),
      modifiedTime: json['modifiedTime']?.toString(),
    );
  }

  factory SheetModel.fromEntity(final SheetEntity entity) {
    return SheetModel(
      id: entity.id,
      title: entity.title,
      createdTime: entity.createdTime,
      modifiedTime: entity.modifiedTime,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'createdTime': createdTime,
    'modifiedTime': modifiedTime,
  };

  SheetEntity toEntity() => SheetEntity(
    id: id,
    title: title,
    createdTime: createdTime,
    modifiedTime: modifiedTime,
  );

  SheetModel copyWith({
    final String? id,
    final String? title,
    final String? createdTime,
    final String? modifiedTime,
  }) {
    return SheetModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdTime: createdTime ?? this.createdTime,
      modifiedTime: modifiedTime ?? this.modifiedTime,
    );
  }
}
