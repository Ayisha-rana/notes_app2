import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbservice {
  static Database? database;

  Future<void> initialization() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, image BLOB)');
    }, version: 1);
    print('Database initialized');
  }

  Future<void> insertToNote({required Map<String, dynamic> note}) async {
    try {
      await database!.insert('note', note, conflictAlgorithm: ConflictAlgorithm.replace);
      print('Note inserted');
    } catch (e) {
      print('Error in insertToNote: $e');
    }
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

  // Delete item based on id
  Future<void> deleteItem(int id) async {
    try {
      await database!.delete(
        'note',
        where: 'id = ?',  // Condition to match the record to be deleted
        whereArgs: [id],  // Arguments for the condition
      );
      print('Item deleted with id: $id');
    } catch (e) {
      print('Error in deleteItem: $e');
    }
  }
}
