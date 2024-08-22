import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('My Notes', style: TextStyle(fontSize: 20, color: Colors.white)),
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
            labelStyle: TextStyle(fontSize: 20), // Match the text style with the original
            indicatorColor: Colors.white, // Optional: Customize indicator color
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Card(
                        color: Colors.grey[900],
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[700],
                          ),
                          title: Text('Title', style: TextStyle(color: Colors.white)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('lorem one two three', style: TextStyle(color: Colors.grey)),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text('10 Jan, 2023 10:15 pm',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.bookmark_border, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.black, // Optional: Match the background color of the app
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
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
