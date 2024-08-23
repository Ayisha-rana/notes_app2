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

  Future<void> addItems(
      {required String title,
        required String description,
        required Uint8List imagePath}) async {
    try {

      Map<String, dynamic> noteDetails = {
        'title': title,
        'description': description,
        'image': imagePath
      };

      print('1');

      await db.insertToNote(note: noteDetails);
      print('2');
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<List<Map<String, dynamic>>> getItems() async {
    return await db.getData();
  }
}
