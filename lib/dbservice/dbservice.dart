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
<<<<<<< HEAD
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
=======
      await database!.insert('note', note,conflictAlgorithm: ConflictAlgorithm.replace);
      print('ghjkjh000000000000000000000000');
    } catch (e) {

    }

    print('dfghjk===========================================================l');
  }

  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final data = await database!.query('note');
      print('Data fetched: $data');
      return data;
    } catch (e) {
      print('Error in getData: $e');
      return [];
    }
  }
>>>>>>> 50ecf98ebd8e4214c2550c391da6852d0236b9d0
}
