import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/components/mydrawer.dart';

class PageWithDrawer extends StatefulWidget {
  final Widget child;
  const PageWithDrawer({super.key, required this.child});

  @override
  State<PageWithDrawer> createState() => _PageWithDrawerState();
}

class _PageWithDrawerState extends State<PageWithDrawer>
    with TickerProviderStateMixin {
  final _drawercontroller = AdvancedDrawerController();
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.lightBlue[700],
      animateChildDecoration: true,
        controller: _drawercontroller,
        drawer: MyDrawer(
          onMenuItemSelect: (route) {
            _drawercontroller.toggleDrawer();
            context.go(route);
          },
        ),
        animationController: _animationController,
        openRatio: 0.5,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue[700],
            leading: IconButton(
              onPressed: () {
                _drawercontroller.showDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
          body: widget.child,
        ));
  }
}
