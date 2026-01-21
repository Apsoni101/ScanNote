import 'package:equatable/equatable.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/result_scan_entity.dart';

class PendingSyncEntity extends Equatable {
  const PendingSyncEntity({
    required this.scan,
    required this.sheetId,
    required this.sheetTitle,
  });

  final ScanResultEntity scan;
  final String sheetId;
  final String sheetTitle;

  PendingSyncEntity copyWith({
    final ScanResultEntity? scan,
    final String? sheetId,
    final String? sheetTitle,
  }) {
    return PendingSyncEntity(
      scan: scan ?? this.scan,
      sheetId: sheetId ?? this.sheetId,
      sheetTitle: sheetTitle ?? this.sheetTitle,
    );
  }

  @override
  List<Object?> get props => <Object?>[scan, sheetId, sheetTitle];
}
