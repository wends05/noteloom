import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
          margin: const EdgeInsets.all(8),
          child: TextField(
              decoration: InputDecoration(
            prefixIcon: SizedBox(
                height: 50,
                width: 50,
                child: SvgPicture.asset("assets/images/app/introimage.svg")),
          ))),
    );
  }
}
