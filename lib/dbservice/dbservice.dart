import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbservice {
  static Database? database;

  Future<void> initialization() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE note(title TEXT,description TEXT,image BLOB )');
    }, version: 1);
    print('ghjkvhkl');
  }

  Future<void> insertToNote({required Map<String, dynamic> note}) async {
    try {
      //
      final a = await database!.insert(
        'note',
        note,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print(a);
    } catch (e) {print(e);
      rethrow;
    }
  }
}
