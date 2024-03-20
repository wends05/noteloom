import 'package:flutter/material.dart';

import 'package:school_app/src/pages/home/bottom_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(color: Colors.lightBlue[700])),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
          ),
          
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const BottomScaffold(),
          ),
        ),
      ],
    );
  }
}
