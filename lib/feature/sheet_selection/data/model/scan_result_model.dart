import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';

part 'scan_result_model.g.dart';

@HiveType(typeId: 1)
class ScanResultModel extends ScanResultEntity {
  const ScanResultModel({
    @HiveField(0) required super.data,
    @HiveField(1) required super.comment,
    @HiveField(2) required super.timestamp,
    @HiveField(3) super.deviceId,
    @HiveField(4) super.userId,
  });

  // ---------- FACTORIES ----------

  factory ScanResultModel.fromEntity(final ScanResultEntity entity) {
    return ScanResultModel(
      data: entity.data,
      comment: entity.comment,
      timestamp: entity.timestamp,
      deviceId: entity.deviceId,
      userId: entity.userId,
    );
  }

  factory ScanResultModel.fromJson(final Map<String, dynamic> json) {
    return ScanResultModel(
      data: json['data']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
      timestamp: json['timestamp'] != null
          ? .parse(json['timestamp'].toString())
          : .now(),
      deviceId: json['deviceId']?.toString(),
      userId: json['userId']?.toString(),
    );
  }

  /// Google Sheets → Model
  factory ScanResultModel.fromSheetRow(final List<dynamic> row) {
    return ScanResultModel(
      timestamp: row.isNotEmpty && row[0] != null
          ? .parse(row[0].toString())
          : .now(),
      data: row.length > 1 ? row[1]?.toString() ?? '' : '',
      comment: row.length > 2 ? row[2]?.toString() ?? '' : '',
      deviceId: row.length > 3 ? row[3]?.toString() : null,
      userId: row.length > 4 ? row[4]?.toString() : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'comment': comment,
    'timestamp': timestamp.toIso8601String(),
    'deviceId': deviceId,
    'userId': userId,
  };

  List<dynamic> toSheetRow() => <dynamic>[
    timestamp.toIso8601String(),
    data,
    comment,
    deviceId ?? '',
    userId ?? '',
  ];

  ScanResultEntity toEntity() {
    return ScanResultEntity(
      data: data,
      comment: comment,
      timestamp: timestamp,
      deviceId: deviceId,
      userId: userId,
    );
  }

  // ---------- COPY ----------

  @override
  ScanResultModel copyWith({
    final String? data,
    final String? comment,
    final DateTime? timestamp,
    final String? deviceId,
    final String? userId,
  }) {
    return ScanResultModel(
      data: data ?? this.data,
      comment: comment ?? this.comment,
      timestamp: timestamp ?? this.timestamp,
      deviceId: deviceId ?? this.deviceId,
      userId: userId ?? this.userId,
    );
  }
}
