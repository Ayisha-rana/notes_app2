import 'package:flutter/material.dart';
import 'package:notes_app2/Homepage.dart';
import 'package:notes_app2/add.dart';

import 'dbservice/dbservice.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Dbservice().initialization();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

  
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
