import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:notes_app2/dbservice/dbservice.dart';

class Details extends StatelessWidget {
  final String title;
  final int id;
  final String description;
  final Uint8List? image;  // Nullable image
  final VoidCallback onDelete;  // Callback function for delete operation

  Details({
    super.key,
    required this.title,
    required this.description,
    required this.id,
    this.image,
    required this.onDelete,  // Initialize the callback
  });

  Dbservice dbservice = Dbservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF6ECC9),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          const SizedBox(width: 7),
          IconButton(
            onPressed: () async {
              await dbservice.deleteItem(id);  // Ensure deletion is complete
              onDelete();  // Call the delete callback
              Navigator.pop(context);  // Go back to the previous screen
            },
            icon: const Icon(Icons.delete),
            color: Colors.redAccent,
          ),
        ],
      ),
      backgroundColor: const Color(0xffF6ECC9),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white54,
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: MemoryImage(image!),  // Use MemoryImage if image is not null
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text('No Image Available'),
                    ),  // Display a placeholder if the image is null
            ),
            const SizedBox(height: 45),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Title: $title',
                style: const TextStyle(fontSize: 19),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description: $description',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
