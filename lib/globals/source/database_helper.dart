import 'package:path/path.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:service_app/modules/notification/data/model/notification_service.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "Services.db";

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE ServiceModel(id INTEGER PRIMARY KEY, image TEXT NOT NULL, name TEXT NOT NULL, price TEXT NOT NULL, url TEXT NOT NULL, start TEXT NOT NULL, end TEXT NOT NULL, note TEXT NOT NULL);"
        );
        await db.execute(
            "CREATE TABLE NotificationServiceModel(id INTEGER PRIMARY KEY, image TEXT NOT NULL, date TEXT NOT NULL, price TEXT NOT NULL, isSwitched INTEGER NOT NULL);"
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
              "CREATE TABLE NotificationServiceModel(id INTEGER PRIMARY KEY, image TEXT NOT NULL, date TEXT NOT NULL, price REAL NOT NULL, isSwitched INTEGER NOT NULL);"
          );
        }
      },
      version: _version,
    );
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

  static Future<int> addNotificationService(NotificationServiceModel model) async {
    final db = await _getDb();
    return await db.insert("NotificationServiceModel", model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<NotificationServiceModel>?> getNotificationServices() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query("NotificationServiceModel");
    print(maps);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => NotificationServiceModel.fromJson(maps[index]));
  }

  static Future<int> updateNotificationService(NotificationServiceModel model) async {
    final db = await _getDb();
    return await db.update(
      "NotificationServiceModel",
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  static Future<void> deleteAllNotificationServices() async {
    final db = await _getDb();
    await db.delete("NotificationServiceModel");
  }
  static Future<double?> getSumOfPrices() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT SUM(CAST(price AS REAL)) as total FROM ServiceModel');

    if (result.isNotEmpty && result[0]['total'] != null) {
      return result[0]['total'] as double;
    }
    return 0.0;
  }

}
