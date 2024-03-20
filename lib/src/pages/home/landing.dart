import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Priority Subjects"),
          Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(color: Colors.amber),
            child: const Text("Hellor"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Recent Notes"),
          Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(color: Colors.amber),
            child: const Text("Hellor"),
          ),
        ],
      ),
    );
  }
}
