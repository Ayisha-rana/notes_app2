import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app2/controller/controller.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }



TextEditingController titlecontroller =  TextEditingController();
TextEditingController descriptioncontroller =  TextEditingController();




void savehandler(){
Controller().addItems(title: titlecontroller.text, description: descriptioncontroller.text, imagePath: _image!.path);
 Navigator.pop(context);

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6ECC9),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center, // Center the Column
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure the Column takes only the space it needs
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null ? FileImage(_image!) : null, // Display the picked image
                      child: _image == null
                          ? Icon(
                              Icons.photo_rounded, // Main icon
                              size: 40, // Adjust size as needed
                              color: Color(0xFFB6A7A3), // Icon color
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage, // Trigger image picker on tap
                        child: Container(
                          padding: EdgeInsets.all(4), // Padding around the add icon
                          decoration: BoxDecoration(
                            color: Color(0xFFB6A7A3), // Background color for the add icon
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add, // Add icon
                            size: 20, // Adjust size as needed
                            color: Colors.white, // Add icon color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Space between CircleAvatar and TextFields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: titlecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'TITLE',
                        ),
                      ),
                      SizedBox(height: 10), // Space between TextFields
                      TextFormField(
                        controller: descriptioncontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'DESCRIPTION',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter, // Align the Save button to the bottom center
            child: GestureDetector(
              onTap: () {
                savehandler();
              },
              child: Container(
                margin: EdgeInsets.all(20), // Margin around the container
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding inside the container
                decoration: BoxDecoration(
                  color: Color(0xFFB6A7A3), // Background color of the container
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
