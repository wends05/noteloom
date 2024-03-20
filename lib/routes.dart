import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:school_app/src/pages/addnote/addnote.dart';
import 'package:school_app/src/pages/home/homepage.dart';
import 'package:school_app/src/pages/login.dart';
import 'package:school_app/src/pages/not_logged_in.dart';
import 'package:school_app/src/pages/settings/settingspage.dart';
import 'package:school_app/src/pages/withdrawer.dart';
import 'package:school_app/src/pages/your_subjects/your_subjects.dart';
import 'package:school_app/src/utils/firebase.dart';
import 'package:school_app/src/pages/intro_page.dart';
import 'package:school_app/src/pages/setup.dart';

class Routes {

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
            name: "intro",
            path: "/",
            pageBuilder: (_, __) => CustomTransitionPage(
                key: __.pageKey,
                transitionDuration: const Duration(milliseconds: 1000),
                child: const IntroPage(),
                transitionsBuilder: (_, anim, __, child) =>
                    fadeTransition(_, anim, __, child))),
        GoRoute(
            name: "login",
            path: "/login/:universityId",
            pageBuilder: (context, state) {
              String universityId = state.pathParameters['universityId']!;

              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  child: Login(
                    universityId: universityId,
                  ),
                  transitionsBuilder: (_, __, ___, child) =>
                      fromRightTransition(_, __, __, child));
            }),

        GoRoute(
            name: "Not Logged In",
            path: "/notLoggedIn",
            builder: (context, state) => const NotLoggedIn()),
        GoRoute(
            name: "setup",
            path: "/setup",
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 500),
                child: const Setup(),
                transitionsBuilder: (_, __, ___, child) =>
                    fromRightTransition(_, __, __, child))),

        // home page routes

        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          
            builder: (context, state, child) => PageWithDrawer(child: child),
            routes: [
              GoRoute(
                name: "home",
                path: "/home",
                pageBuilder: (_, __) => CustomTransitionPage(
                    key: __.pageKey,
                    transitionDuration: const Duration(milliseconds: 500),
                    child: const HomePage(),
                    transitionsBuilder: (_, anim, __, child) =>
                        fadeTransition(_, anim, __, child)),
              ),
              GoRoute(
                path: "/your_subjects",
                pageBuilder: (_, __) => CustomTransitionPage(
                    key: __.pageKey,
                    maintainState: true,
                    transitionDuration: const Duration(milliseconds: 1000),
                    child: const YourSubjects(),
                    transitionsBuilder: (_, anim, __, child) =>
                        fadeTransition(_, anim, __, child)),
              ),
              GoRoute(
                path: "/addnote",
                pageBuilder: (_, __) => CustomTransitionPage(
                    key: __.pageKey,
                    transitionDuration: const Duration(milliseconds: 1000),
                    child: const AddNote(),
                    transitionsBuilder: (_, anim, __, child) =>
                        fadeTransition(_, anim, __, child)),
              ),
              GoRoute(
                path: "/settings",
                pageBuilder: (_, __) => CustomTransitionPage(
                    key: __.pageKey,
                    transitionDuration: const Duration(milliseconds: 500),
                    child: const SettingsPage(),
                    transitionsBuilder: (_, anim, __, child) =>
                        fadeTransition(_, anim, __, child)),
              ),
            ])
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
        return null;
      });
}

SlideTransition fromRightTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return SlideTransition(
    position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeInOutQuad))),
    child: child,
  );
}

SlideTransition fromBottomTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return SlideTransition(
    position: animation.drive(Tween(begin: const Offset(0, 1), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeInOutQuad))),
    child: child,
  );
}

FadeTransition fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: Tween(begin: 0.toDouble(), end: 1.toDouble())
        .animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
    child: child,
  );
}
