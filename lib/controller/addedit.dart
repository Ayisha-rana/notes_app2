import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker package
import 'package:notes_app2/controller/controller.dart';

class AddEditPage extends StatefulWidget {
  final int? id;
  final String? title;
  final String? description;
  final Uint8List? image;
  final VoidCallback? onSave;  // Callback for saving

  const AddEditPage({
    super.key,
    this.id,
    this.title,
    this.description,
    this.image,
    this.onSave,
  });

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final Controller controller = Controller();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Uint8List? image;  // Image data

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      titleController.text = widget.title ?? '';
      descriptionController.text = widget.description ?? '';
      image = widget.image;  // Set the image
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      setState(() {
        image = imageFile.readAsBytesSync();
      });
    }
  }

  Future<void> saveItem() async {
    if (widget.id != null) {
      await controller.updateItem(
        id: widget.id!,
        title: titleController.text,
        description: descriptionController.text,
        imagePath: image!,
      );
    } else {
      await controller.addItems(
        title: titleController.text,
        description: descriptionController.text,
        imagePath: image!,
      );
    }

    if (widget.onSave != null) {
      widget.onSave!();  // Call the onSave callback
    }

    Navigator.pop(context);  // Return to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6ECC9),
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
                      backgroundImage: image != null ? MemoryImage(image!) : null,
                      child: image == null
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
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFFB6A7A3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'TITLE',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
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
              onTap: saveItem, // Trigger the save handler function
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Color(0xFFB6A7A3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
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
