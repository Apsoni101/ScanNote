class NetworkConstants {
  /// Sheets API URLs
  static const String sheetsBaseUrl =
      'https://sheets.googleapis.com/v4/spreadsheets';

  /// Drive API URLs
  static const String driveBaseUrl =
      'https://www.googleapis.com/drive/v3/files';

  /// Query parameters
  static const String sheetMimeType = 'application/vnd.google-apps.spreadsheet';
  static const String sheetFields =
      'files(id,name,createdTime,modifiedTime,properties,description)';
  static const int pageSize = 100;
  static const String orderBy = 'modifiedTime%20desc';
  static const String clearRangeSuffix = ':clear';
  static const String appendRange = 'A2:append';
}
