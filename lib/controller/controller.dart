import 'dart:io';
import 'dart:typed_data';
import 'package:notes_app2/dbservice/dbservice.dart';

class Controller {
  Dbservice db = Dbservice();

  static List<Map<String, dynamic>> items = [];

  Future<Uint8List> imageToBytes(String imagePath) async {
    File imageFile = File(imagePath);
    return await imageFile.readAsBytes();
  }

  Future<void> addItems({
    required String title,
    required String description,
    required Uint8List imagePath,
  }) async {
    try {
      Map<String, dynamic> noteDetails = {
        'title': title,
        'description': description,
        'image': imagePath
      };

      print('1');

      await db.insertToNote(note: noteDetails);

      items = await db.getData();
      print('2');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    try {
      items = await db.getData();
      print('Fetched items: $items');
      return items;
    } catch (e) {
      print('Error in getItems: $e');
      return [];
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await db.deleteItem(id);  // Call the delete function from Dbservice
      print('Item deleted: $id');
      
      // Refresh the items list
      items = await db.getData();
    } catch (e) {
      print('Error in deleteItem: $e');
    }
  }
}
