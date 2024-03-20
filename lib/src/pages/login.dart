import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:school_app/src/utils/firebase.dart';
import 'package:school_app/src/utils/models.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.universityId});
  final String universityId;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _universityName = "";
  @override
  void initState() {
    super.initState();
    Database.db
        .doc("/universities/${widget.universityId}")
        .withConverter(
            fromFirestore: UniversityModel.fromFirestore,
            toFirestore: (m, _) => m.toFirestore())
        .get()
        .then((value) {
      final data = value.data();
      if (data != null) {
        setState(() {
          _universityName = data.name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                    height: 50,
                    child: _universityName.isNotEmpty
                        ? Text(
                            _universityName,
                            style: const TextStyle(fontSize: 30),
                          )
                        : const LoadingIndicator(
                            indicatorType: Indicator.ballTrianglePathColored,
                          )),
                const Text("Log in with your school account."),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.go("/home");
              },
              child: const Text("Log In"),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go("/");
              },
              child: const Text("Return to Home Page"),
            ),
          ],
        ),
      ),
    ));
  }
}
