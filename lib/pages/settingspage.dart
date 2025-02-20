import 'package:flutter/material.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: [
          
          Container(
            height: 70, // Increase the height as needed
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
              onTap: () {
                // Navigate to notification settings
              },
            ),
          ),
          Container(
            height: 70, // Increase the height as needed
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text("Privacy"),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
          ),
          Container(
            height: 70, // Increase the height as needed
            child: ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              onTap: () {
                // Navigate to help section
              },
            ),
          ),
          Container(
            height: 70, // Increase the height as needed
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {
                // Navigate to about section
              },
            ),
          ),
        ],
      ),
    );
  }
}