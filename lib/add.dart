import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6ECC9),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter, // Align the Column to the top center
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure the Column takes only the space it needs
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.photo_rounded, // Main icon
                        size: 40, // Adjust size as needed
                        color: Color(0xFFB6A7A3), // Icon color
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
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
                  ],
                ),
                SizedBox(height: 20), // Space between CircleAvatar and TextFields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'TITLE',
                        ),
                      ),
                      SizedBox(height: 10), // Space between TextFields
                      TextFormField(
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
                Navigator.pop(context);
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
