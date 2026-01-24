import 'package:hive/hive.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/scan_result_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/sheet_model.dart';

class HiveService {
  late Box _box;

  /// Initialize Hive and open a box
  static void registerAdapters() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ScanResultModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SheetModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(PendingSyncModelAdapter());
    }
  }

  Future<void> init({required final String boxName}) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }

    _box = await Hive.openBox(boxName);
  }

  Future<void> setString(final String key, final String value) async {
    await _box.put(key, value);
  }

  String? getString(final String key) {
    return _box.get(key) as String?;
  }

  Future<void> remove(final String key) async {
    await _box.delete(key);
  }

  Future<void> setObjectList<T>(final String key, final List<T> objects) async {
    await _box.put(key, objects);
  }

  List<T>? getObjectList<T>(final String key) {
    return (_box.get(key) as List<dynamic>?)?.cast<T>();
  }
}
