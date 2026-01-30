import 'package:hive/hive.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/scan_result_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/pending_sync_entity.dart';

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
      scan: .fromEntity(entity.scan),
      sheetId: entity.sheetId,
      sheetTitle: entity.sheetTitle,
    );
  }

  factory PendingSyncModel.fromJson(final Map<String, dynamic> json) {
    return PendingSyncModel(
      scan: .fromJson(json['scan'] ?? <String, dynamic>{}),
      sheetId: json['sheetId'] ?? '',
      sheetTitle: json['sheetTitle'] ?? '',
    );
  }

  @HiveField(0)
  final ScanResultModel scan;

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
    final ScanResultModel? scan,
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
