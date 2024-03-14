import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/not_logged_in.dart';
import 'package:school_app/src/utils/firebase.dart';
import 'package:school_app/src/confirmlogin.dart';
import 'package:school_app/src/register.dart';
import 'package:school_app/src/home/homepage.dart';
import 'package:school_app/src/intro_page.dart';
import 'package:school_app/src/login.dart';
import 'package:school_app/src/setup.dart';
import 'package:school_app/src/utils/models.dart';

final routes = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: "intro",
        path: "/",
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        name: "home",
        path: "/home",
        builder: (context, state) => const HomePage(),
        redirect: (context, state) async {
          final user = await Database.getUser();

          if (user is UserModel &&
              (user.universityId == null || user.username == null)) {
            return "/setup";
          }

          if (Auth.auth.currentUser == null) {
            return "/notLoggedIn";
          }
          return "/home";
        },
      ),
      GoRoute(
        name: "login",
        path: "/login",
        builder: (context, state) => const Login(),
      ),
      GoRoute(
          name: "register",
          path: "/register",
          builder: (context, state) => const Register()),
      GoRoute(
          name: "Confirm Login",
          path: "/confirmLogin",
          builder: (context, state) => const ConfirmLogin()),
      GoRoute(
          name: "Not Logged In",
          path: "/notLoggedIn",
          builder: (context, state) => const NotLoggedIn()),
      GoRoute(
          name: "setup",
          path: "/setup",
          builder: (context, state) => const Setup())
    ],
    redirect: (context, state) {
      bool isOnPath(String path) {
        return state.matchedLocation.startsWith(path);
      }

      if (isOnPath("/login")) {
        if (Auth.auth.currentUser != null) {
          return "/setup";
        }
      }

      if (isOnPath("/setup")) {
        if (Auth.auth.currentUser == null) {
          return "/login";
        }
      }
      return null;
    });
