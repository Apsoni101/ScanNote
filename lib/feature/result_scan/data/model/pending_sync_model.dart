import 'package:hive/hive.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/result_scan_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/pending_sync_entity.dart';

part 'pending_sync_model.g.dart';

@HiveType(typeId: 3)
class PendingSyncModel extends HiveObject {
  PendingSyncModel({
    required this.scan,
    required this.sheetId,
    required this.sheetTitle,
  });

  factory PendingSyncModel.fromEntity(final PendingSyncEntity entity) {
    return PendingSyncModel(
      scan: ResultScanModel.fromEntity(entity.scan),
      sheetId: entity.sheetId,
      sheetTitle: entity.sheetTitle,
    );
  }

  factory PendingSyncModel.fromJson(final Map<String, dynamic> json) {
    return PendingSyncModel(
      scan: ResultScanModel.fromJson(json['scan'] ?? <String, dynamic>{}),
      sheetId: json['sheetId'] ?? '',
      sheetTitle: json['sheetTitle'] ?? '',
    );
  }

  @HiveField(0)
  final ResultScanModel scan;

  @HiveField(1)
  final String sheetId;

  @HiveField(2)
  final String sheetTitle;

  PendingSyncEntity toEntity() {
    return PendingSyncEntity(
      scan: scan.toEntity(),
      sheetId: sheetId,
      sheetTitle: sheetTitle,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'scan': scan.toJson(),
      'sheetId': sheetId,
      'sheetTitle': sheetTitle,
    };
  }

  PendingSyncModel copyWith({
    final ResultScanModel? scan,
    final String? sheetId,
    final String? sheetTitle,
  }) {
    return PendingSyncModel(
      scan: scan ?? this.scan,
      sheetId: sheetId ?? this.sheetId,
      sheetTitle: sheetTitle ?? this.sheetTitle,
    );
  }
}
