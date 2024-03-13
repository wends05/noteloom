import 'package:go_router/go_router.dart';
import 'package:school_app/firebase.dart';
import 'package:school_app/src/confirmlogin.dart';
import 'package:school_app/src/register.dart';
import 'package:school_app/src/home/homepage.dart';
import 'package:school_app/src/intro_page.dart';
import 'package:school_app/src/login.dart';
import 'package:school_app/src/setup.dart';

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
          redirect: (context, state) {
            if (FirebaseBackend.user == null) {
              return "/login";
            }
            return "/home";
          }),
      GoRoute(
          name: "login",
          path: "/login",
          builder: (context, state) => const Login()),
      GoRoute(
          name: "register",
          path: "/register",
          builder: (context, state) => const Register()),
      GoRoute(
          name: "Confirm Login",
          path: "/confirmLogin",
          builder: (context, state) => const ConfirmLogin()),
      GoRoute(name: "setup", path: "/setup", builder: (context, state) => const Setup())
    ],
    redirect: (context, state) {
      if (state.matchedLocation.startsWith("/login") ||
          state.matchedLocation.startsWith("/register")) {
        if (FirebaseBackend.user != null) {
          return "/confirmLogin";
        }
      }
      return null;
    });
