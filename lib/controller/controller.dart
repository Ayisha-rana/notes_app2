class Controller {
  static List<Map<String,dynamic>> items=[

  ];


  void addItems({required String title, required String description, required String imagePath}){

Map<String,dynamic> noteDetails = {'title':title,'description':description,'imagePath':imagePath};
items.add(noteDetails);
print(items);
  }
}