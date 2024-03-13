import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  void onIntroEnd(context) {
    GoRouter.of(context).go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: IntroductionScreen(
              pages: viewModels,
              showSkipButton: false,
              skip: const Text("Skip"),
              next: const Icon(Icons.arrow_forward_ios),
              done: const Text("Done"),
              onDone: () {
                onIntroEnd(context);
              }),
        ));
  }
}

final viewModels = [
  PageViewModel(title: "Welcome to Note Loom", body: ""),
  PageViewModel(
    title: "Create Notes",
    body: "Post your notes and share with it with the University",
  ),
  PageViewModel(
    title: "Find Notes",
    body: "Find notes from your department",
  )
];
