import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:school_app/src/components/mybottomnavbar.dart';
import 'package:school_app/src/pages/home/prioritysubjects.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  PersistentBottomNavBarItem _bottomNavBarItem(IconData icon, String? text) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: text,
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    );
  }


  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      _bottomNavBarItem(Icons.book, 'Priority Subjects'),
      _bottomNavBarItem(Icons.note_sharp, 'Recent Notes'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView.custom(
          context,
          itemCount: _navBarItems().length,
          screens: const [
            PrioritySubjects(),
            PrioritySubjects()
          ],
          confineInSafeArea: true,
          customWidget: MyBottomNavBar(
            items: _navBarItems(),
            index: 0,
            onItemSelected: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/prioritysubjects');
              } else {
                Navigator.pushNamed(context, '/recentnotes');
              }
            },
          )
          
        ));
  }

  
}
