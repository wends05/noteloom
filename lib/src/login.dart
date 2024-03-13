import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/firebase.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailControl.dispose();
    passwordControl.dispose();
  }

  Widget createInputField(
      String label, bool isPassword, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextFormFieldRow(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            obscureText: isPassword,
            controller: control,
            placeholder: label,
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.black),
              borderRadius: BorderRadius.circular(2),
            ),
          )
        ],
      ),
    );
  }

  void login() async {
    await FirebaseBackend()
        .login(emailControl.text, passwordControl.text)
        .then((value) => GoRouter.of(context).go("/home"));
  }

  void googleLogIn() async {
    await FirebaseBackend().googleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Log In",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200]),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  createInputField(
                    "Email",
                    false,
                    emailControl,
                  ),
                  createInputField("Password", true, passwordControl),
                  CupertinoButton(
                      onPressed: login, child: const Text("Log In")),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Don't have an account?"),
                    CupertinoButton(
                        onPressed: () {
                          GoRouter.of(context).replace("/register");
                        },
                        child: const Text("Register here"))
                  ])
                ],
              ),
            ),
          ),
          CupertinoButton.filled(
            onPressed: googleLogIn,
            child: const Text("Sign in with Google"),
          )
        ],
      ),
    ));
  }
}
