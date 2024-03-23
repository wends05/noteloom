import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrioritySubjects extends StatefulWidget {
  const PrioritySubjects({super.key});

  @override
  State<PrioritySubjects> createState() => _PrioritySubjectsState();
}

class _PrioritySubjectsState extends State<PrioritySubjects> {
  final _scrollController = ScrollController();
  bool isScrolled = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200 - kToolbarHeight) {
        setState(() {
          isScrolled = true;
        });
      } else {
        setState(() {
          isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


     @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.lightBlue[700],
            expandedHeight: 200,
            pinned: true,
            
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.fadeTitle],
              title: isScrolled ? null : Text('Home Page'),
            ),
            title: isScrolled ? const Text('Home Page') : null,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
