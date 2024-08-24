import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:notes_app2/controller/addedit.dart';
import 'package:notes_app2/dbservice/dbservice.dart';

class Details extends StatefulWidget {
  final String title;
  final int id;
  final String description;
  final Uint8List? image;  // Nullable image

  Details({
    super.key,
    required this.title,
    required this.description,
    required this.id,
    this.image, required Future<Null> Function() onDelete,
  });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Dbservice dbservice;
  late String title;
  late String description;
  late Uint8List? image;

  @override
  void initState() {
    super.initState();
    dbservice = Dbservice();
    title = widget.title;
    description = widget.description;
    image = widget.image;
  }

  void _updateDetails() async {
    // Fetch updated data from the database
    final data = await dbservice.getData();
    final updatedNote = data.firstWhere((note) => note['id'] == widget.id, orElse: () => {});
    
    setState(() {
      title = updatedNote['title'] ?? widget.title;
      description = updatedNote['description'] ?? widget.description;
      image = updatedNote['image'];  // Update image if necessary
    });
  }

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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPage(
                    id: widget.id,
                    title: title,
                    description: description,
                    image: image,
                    onSave: _updateDetails,  // Pass the callback
                  ),
                ),
              ).then((_) {
                // Refresh the data when returning from AddEditPage
                _updateDetails();
              });
            },
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(width: 7),
          IconButton(
            onPressed: () async {
              await dbservice.deleteItem(widget.id);
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
                        image: MemoryImage(image!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text('No Image Available'),
                    ),
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
