import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  final Function(String) onMenuItemSelect;
  const MyDrawer({super.key, required this.onMenuItemSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue[700],
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: const 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Note\nLoom",
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: const Text("Home"),
                onTap: () {
                  onMenuItemSelect('/home');
                },
              ),
              ListTile(
                title: const Text("Settings"),
                onTap: () {
                  onMenuItemSelect('/settings');
                },
              ),
              ListTile(
                title: const Text("Your Subjects"),
                onTap: () {
                  onMenuItemSelect('/your_subjects');
                },
              ),
              ListTile(
                title: const Text("Add Note"),
                onTap: () {
                  onMenuItemSelect('/addnote');
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
