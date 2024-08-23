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
<<<<<<< HEAD
      required String description,
      required String imagePath}) async{
    Map<String, dynamic> noteDetails = {
      'title': title,
      'description': description,
      'imagePath': imagePath
    };

    try{

    await   db.insertToNote(note: noteDetails);
=======
        required String description,
        required Uint8List imagePath}) async {
    try {
>>>>>>> 50ecf98ebd8e4214c2550c391da6852d0236b9d0

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
<<<<<<< HEAD
    catch(e){
      

=======
  }
  Future<List<Map<String, dynamic>>> getItems() async {
    try {
      items = await db.getData();
      print('Fetched items: $items');
      return items;
    } catch (e) {
      print('Error in getItems: $e');
      return [];
>>>>>>> 50ecf98ebd8e4214c2550c391da6852d0236b9d0
    }
  }
}
