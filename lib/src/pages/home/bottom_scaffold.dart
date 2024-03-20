import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:school_app/src/pages/home/landing.dart';
import 'package:school_app/src/pages/home/profile.dart';
import 'package:school_app/src/pages/home/search.dart';

class BottomScaffold extends StatefulWidget {
  const BottomScaffold({
    super.key,
  });

  @override
  State<BottomScaffold> createState() => _BottomScaffoldState();
}

class _BottomScaffoldState extends State<BottomScaffold> {
  int _tabIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _tabIndex = value;
          });
        },
        children: const [
          Landing(),
          Search(),
          Profile(),
        ].map(_layoutPage).toList(),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SalomonBottomBar(
          currentIndex: _tabIndex,
          onTap: (i) {
            setState(() {
              _tabIndex = i;
              _pageController.animateToPage(i,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home), title: const Text("Home")),
            SalomonBottomBarItem(
                icon: const Icon(Icons.search_rounded),
                title: const Text("Search")),
            SalomonBottomBarItem(
                icon: const Icon(Icons.person_rounded),
                title: const Text("Profile")),
          ],
        ),
      ),
    );
  }
}

Widget _layoutPage(Widget page) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(child: page),
  );
}
