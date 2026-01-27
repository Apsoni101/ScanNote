import 'package:qr_scanner_practice/feature/sheet_selection/data/model/sheet_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';

class PagedSheetsModel extends PagedSheetsEntity {
  const PagedSheetsModel({
    required List<SheetModel> super.sheets,
    required super.nextPageToken,
    required super.hasMore,
  });

  factory PagedSheetsModel.fromJson(final Map<String, dynamic> json) {
    final List<dynamic> files = json['files'] ?? <dynamic>[];
    final String? pageToken = json['nextPageToken'];

    return PagedSheetsModel(
      sheets: files
          .map((final f) => SheetModel.fromJson(f ?? <String, dynamic>{}))
          .toList(),
      nextPageToken: pageToken,
      hasMore: pageToken != null && pageToken.isNotEmpty,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'files': sheets
          .cast<SheetModel>()
          .map((final sheet) => sheet.toJson())
          .toList(),
      'nextPageToken': nextPageToken,
    };
  }
}
