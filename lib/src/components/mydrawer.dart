import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDrawer extends StatelessWidget {
  final Function(String) onMenuItemSelect;
  const MyDrawer({super.key, required this.onMenuItemSelect});

  ListTile _buildListTile(String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        onMenuItemSelect(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue[700],
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Note\nLoom",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 2,
          color: Colors.white,
        ),
        const SizedBox(
          height: 20,
        ),
        
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            _buildListTile("Home", Icons.home, "/home"),
            _buildListTile("Find Notes", Icons.note, "/find_notes"),
            _buildListTile("Find Subjects", Icons.home, "/find_subjects"),
            _buildListTile("Share a Note", Icons.note, "/addnote"),

          ],)
          ),
        
      ]),
    );
  }
}
