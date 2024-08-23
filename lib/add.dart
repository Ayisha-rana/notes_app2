import 'dart:io';
import 'dart:typed_data';
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
  Uint8List? _imageBytes; // Byte data of the image

  // Image picker function to pick the image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Convert image to bytes
      _imageBytes = await _image!.readAsBytes();
    }
  }

  // Text controllers for title and description
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  // Save handler function
  Future<void> saveHandler() async {
    if (_imageBytes != null && titlecontroller.text.isNotEmpty && descriptioncontroller.text.isNotEmpty) {
      await Controller().addItems(
        title: titlecontroller.text,
        description: descriptioncontroller.text,
        imagePath: _imageBytes!, // Send image as bytes (blob)
      );
      Navigator.pop(context, true); // Close the page and indicate success
    } else {
      // Handle the case when no image is selected or fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and select an image!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6ECC9),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                        Icons.photo_rounded,
                        size: 40,
                        color: Color(0xFFB6A7A3),
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFFB6A7A3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                      SizedBox(height: 10),
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
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: saveHandler, // Trigger the save handler function
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Color(0xFFB6A7A3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
