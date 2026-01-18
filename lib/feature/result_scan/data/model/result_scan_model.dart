import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';

part 'result_scan_model.g.dart';

@HiveType(typeId: 1)
class ResultScanModel extends ResultScanEntity {
  const ResultScanModel({
    @HiveField(0) required super.data,
    @HiveField(1) required super.comment,
    @HiveField(2) required super.timestamp,
    @HiveField(3) super.deviceId,
    @HiveField(4) super.userId,
  });

  // ---------- FACTORIES ----------

  factory ResultScanModel.fromEntity(final ResultScanEntity entity) {
    return ResultScanModel(
      data: entity.data,
      comment: entity.comment,
      timestamp: entity.timestamp,
      deviceId: entity.deviceId,
      userId: entity.userId,
    );
  }

  factory ResultScanModel.fromJson(final Map<String, dynamic> json) {
    return ResultScanModel(
      data: json['data']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'].toString())
          : DateTime.now(),
      deviceId: json['deviceId']?.toString(),
      userId: json['userId']?.toString(),
    );
  }

  /// Google Sheets → Model
  factory ResultScanModel.fromSheetRow(final List<dynamic> row) {
    return ResultScanModel(
      timestamp: row.isNotEmpty && row[0] != null
          ? DateTime.parse(row[0].toString())
          : DateTime.now(),
      data: row.length > 1 ? row[1]?.toString() ?? '' : '',
      comment: row.length > 2 ? row[2]?.toString() ?? '' : '',
      deviceId: row.length > 3 ? row[3]?.toString() : null,
      userId: row.length > 4 ? row[4]?.toString() : null,
    );
  }

  // ---------- MAPPERS ----------

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'comment': comment,
    'timestamp': timestamp.toIso8601String(),
    'deviceId': deviceId,
    'userId': userId,
  };

  Map<String, dynamic> toHiveMap() => <String, dynamic>{
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



  ResultScanEntity toEntity() {
    return ResultScanEntity(
      data: data,
      comment: comment,
      timestamp: timestamp,
      deviceId: deviceId,
      userId: userId,
    );
  }

  // ---------- COPY ----------

  @override
  ResultScanModel copyWith({
    final String? data,
    final String? comment,
    final DateTime? timestamp,
    final String? deviceId,
    final String? userId,
  }) {
    return ResultScanModel(
      data: data ?? this.data,
      comment: comment ?? this.comment,
      timestamp: timestamp ?? this.timestamp,
      deviceId: deviceId ?? this.deviceId,
      userId: userId ?? this.userId,
    );
  }
}
