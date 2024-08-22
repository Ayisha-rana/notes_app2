import 'package:notes_app2/dbservice/dbservice.dart';

class Controller {

  Dbservice db =Dbservice();

  static List<Map<String, dynamic>> items = [];

  void addItems(
      {required String title,
      required String description,
      required String imagePath}) {
    Map<String, dynamic> noteDetails = {
      'title': title,
      'description': description,
      'imagePath': imagePath
    };

    try{

      db.insertToNote(note: noteDetails);




    }
    catch(e){

    }

  }
}
