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
        where: 'id = ?',  
        whereArgs: [id],  
      );
      print('Item deleted with id: $id');
    } catch (e) {
      print('Error in deleteItem: $e');
    }
  }
   Future<void> updateNoteDate(int id, String date) async {
  try {
    await database!.update(
      'note',
      {'date': date}, // Set the new date value
      where: 'id = ?', // Specify which record to update
      whereArgs: [id],
    );
    print('Note updated with new date');
  } catch (e) {
    print('Error in updateNoteDate: $e');
  }
}

}
