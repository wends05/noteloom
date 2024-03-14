import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NotLoggedIn extends StatefulWidget {
  const NotLoggedIn({super.key});

  @override
  State<NotLoggedIn> createState() => _NotLoggedInState();
}

class _NotLoggedInState extends State<NotLoggedIn> {
  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Not Logged In"),
    const      SizedBox(height: 20,),
          CupertinoButton.filled(
              child: const Text("Log In"),
              onPressed: () {
                GoRouter.of(context).go("/login");
              })
        ],
      ),
    ));
  }
}
