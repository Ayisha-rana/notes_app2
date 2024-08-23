import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:notes_app2/add.dart';
import 'package:notes_app2/controller/controller.dart';
import 'package:notes_app2/details.dart';

class Homepage extends StatefulWidget {



  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<Map<String, dynamic>> _notes = []; // Store the notes from the database

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Fetch the notes when the page loads
  }

  // Fetch the data from the database
  Future<void> _fetchNotes() async {
    List<Map<String, dynamic>> data = await Controller().getItems();
    setState(() {
      _notes = data;
    });
  }






  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('My Notes',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[700],
                child: Text('Logo'),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Important'),
            ],
            labelStyle: TextStyle(
                fontSize: 20), // Match the text style with the original
            indicatorColor: Colors.white, // Optional: Customize indicator color
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      final image = note['image'] as Uint8List?;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Details()));
                        },
                        child: Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: image != null ? MemoryImage(image as Uint8List) : null,
                              backgroundColor: Colors.grey[700],
                              child: image == null ? Icon(Icons.photo_rounded, color: Colors.white) : null,
                            ),
                            title: Text(note['title'] ?? 'No Title', style: TextStyle(color: Colors.white)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(note['description'] ?? 'No Description', style: TextStyle(color: Colors.grey)),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text('10 Jan, 2023 10:15 pm', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.bookmark_border, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    color: Colors
                        .black, // Optional: Match the background color of the app
                    child: Center(
                      child: Text(''), // Empty text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[700],
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPage())).then((value) {
              _fetchNotes();

                },);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
