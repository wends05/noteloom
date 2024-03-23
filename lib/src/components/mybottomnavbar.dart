import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar(
      {super.key,
      required this.items,
      required this.index,
      required this.onItemSelected});

  final List<PersistentBottomNavBarItem> items;
  final int index;
  final ValueChanged<int> onItemSelected;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
