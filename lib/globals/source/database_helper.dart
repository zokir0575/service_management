import 'package:path/path.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Services.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE ServiceModel(id INTEGER PRIMARY KEY, image NOT NULL, name NOT NULL, price NOT NULL,  url NOT NULL, start NOT NULL, end NOT NULL, note NOT NULL);"),
        version: _version);
  }

  static Future<int> addService(ServiceModel model) async {
    final db = await _getDb();
    print(model.toJson());
    return await db.insert("ServiceModel", model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<ServiceModel>?> getServices() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query("ServiceModel");
    print(maps);
    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => ServiceModel.fromJson(maps[index]));
  }
  static Future<void> deleteAllServices() async {
    final db = await _getDb();
    await db.delete("ServiceModel");
  }
}
