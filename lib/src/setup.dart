import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/utils/firebase.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  late final List userNames;
  final _formKey = GlobalKey();

  final usernameControl = TextEditingController();
  final nameControl = TextEditingController();
  final schoolEmailControl = TextEditingController();
  final departmentControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Database.getUsernames().then((value) {
      userNames = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    usernameControl.dispose();
    nameControl.dispose();
    schoolEmailControl.dispose();
    departmentControl.dispose();
  }

  Widget textInput(String name, TextEditingController control) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: CupertinoTextFormFieldRow(
          controller: control,
          validator: (value) {
            if (name == "Username") {
              if (userNames.contains(value)) {
                return "This username is already taken";
              }
            }
            if (value != null && value.isEmpty) {
              return "This field should not be empty";
            }
            return null;
          },
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.black),
            borderRadius: BorderRadius.circular(2),
          ),
          placeholder: name,
        ));
  }

  void logOut() async {
    await Auth().signOut().then((value) {
      GoRouter.of(context).go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to Note Loom!"),
            const Text("To get started, please setup your account."),
            Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    textInput("Name", nameControl),
                    textInput("Username", usernameControl),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("You are currently logged in as:"),
                    Text(Auth.auth.currentUser!.email!),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("If this is not you,"),
                        CupertinoButton(
                            onPressed: logOut, child: const Text("Sign Out"))
                      ],
                    ),
                    CupertinoButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          if (true) {}
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
