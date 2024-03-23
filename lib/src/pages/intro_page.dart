import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/utils/firebase.dart';
import 'package:school_app/src/utils/models.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _findUniversity = TextEditingController();

  bool isOnLogin = false;

  List<UniversityModel> universities = <UniversityModel>[];
  List<UniversityModel> filterUniversities = [];
  @override
  void initState() {
    Database.getUniversities().then((value) {
      universities = value;
      filterUniversities = universities;
      if (kDebugMode) {
        print(universities);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _findUniversity.dispose();
  }

  void _displayUniversities(String input) {
    if (kDebugMode) {
      print(input);
    }

    setState(() {
      filterUniversities = universities
          .where((element) =>
              element.name.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                  child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy > 100) {
                          setState(() {
                            isOnLogin = false;
                          });
                        }

                        if (details.velocity.pixelsPerSecond.dy < 100) {
                          setState(() {
                            isOnLogin = true;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        margin: EdgeInsets.only(
                          bottom: isOnLogin
                              ? MediaQuery.of(context).size.height * 0.25
                              : 0,
                        ),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease,
                        child: SvgPicture.asset(
                          "assets/images/app/introimage.svg",
                          height: MediaQuery.of(context).size.height * 0.7,
                        ),
                      ))),
              Positioned(
                top: 0,
                left: 0,
                child: AnimatedOpacity(
                  opacity: isOnLogin ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  child: Container(
                    height: 300,
                    margin: const EdgeInsets.only(left: 50, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome to",
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "Note Loom",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            "Find and share your notes\nwitin your university."),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            child: const Text("Get Started"),
                            onPressed: () {
                              setState(() {
                                isOnLogin = !isOnLogin;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom:
                    isOnLogin ? 0 : -MediaQuery.of(context).size.height * 0.7,
                curve: Curves.ease,
                duration: isOnLogin
                    ? const Duration(milliseconds: 600)
                    : const Duration(milliseconds: 1500),
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dy > 100) {
                      setState(() {
                        isOnLogin = false;
                      });
                    }
                  },
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Check if your school is\navailable:",
                                style: TextStyle(fontSize: 40),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: _findUniversity,
                                onChanged: (value) {
                                  _displayUniversities(value);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              // used for list of universities

                              Expanded(
                                child: SingleChildScrollView(
                                  child: filterUniversities.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: filterUniversities.length,
                                          itemBuilder: (context, index) {
                                            final university =
                                                filterUniversities[index];
                                            return ListTile(
                                              onTap: () {
                                                setState(() {
                                                  _findUniversity.text =
                                                      university.name;
                                                });
                                              },
                                              tileColor: Colors.grey[200],
                                              title: Text(university.name),
                                            );
                                          },
                                        )
                                      : Container(), // Add a container if the universities list is empty
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (universities
                                        .map((_) => _.name)
                                        .contains(_findUniversity.text)) {
                                      final uniModel = universities.singleWhere(
                                          (element) =>
                                              element.name ==
                                              _findUniversity.text);
                                      GoRouter.of(context).goNamed("login",
                                          pathParameters: {
                                            "universityId": uniModel.id!
                                          });
                                    }
                                  },
                                  child: const Text("Get Started"),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
