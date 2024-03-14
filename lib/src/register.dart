import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/utils/firebase.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final confirmPasswordControl = TextEditingController();

  String loading = "";

  @override
  void dispose() {
    super.dispose();
    emailControl.dispose();
    passwordControl.dispose();
    confirmPasswordControl.dispose();
  }

  Widget createInputField(
      String label, bool isPassword, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CupertinoTextFormFieldRow(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }

            if (label == "Confirm Password") {
              if (value != passwordControl.text) {
                return "Passwords do not match";
              }
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
      ]),
    );
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = "Loading...";
      });

      await Auth()
          .register(emailControl.text, passwordControl.text)
          .then((value) => GoRouter.of(context).go("setupProfile"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        "Register",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                createInputField("Email", false, emailControl),
                createInputField("Password", true, passwordControl),
                createInputField(
                    "Confirm Password", true, confirmPasswordControl),
                CupertinoButton(
                    onPressed: register, child: const Text("Register")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    CupertinoButton(
                        onPressed: () {
                          GoRouter.of(context).replace("/login");
                        },
                        child: const Text("Log In"))
                  ],
                ),
                Text(loading)
              ],
            )),
      ),
    ])));
  }
}
