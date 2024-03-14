import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:school_app/src/utils/models.dart';

Future functionWithTryCatchFirebase(Future Function() function) async {
  try {
    final result = await function();
    return result;
  } on FirebaseAuthException catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

class Auth {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  static final googleProvider = GoogleAuthProvider();

  Future login(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((cred) async {
        await Database.getUser();
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  Future googleSignIn() async {
    try {
      late User? userCred;

      if (kIsWeb) {
        userCred = await auth
            .signInWithPopup(googleProvider)
            .then((cred) => cred.user);
      } else {
        userCred = await auth
            .signInWithProvider(googleProvider)
            .then((cred) => cred.user);
      }

      if (kDebugMode) {
        print(auth.currentUser);
        print("$userCred, Auth");
        print({"id": auth.currentUser!.uid, "email": auth.currentUser!.email});
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return;
    }
  }

  Future register(String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {});
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> signOut() async {
    functionWithTryCatchFirebase(() async {
      await auth.signOut();
    });
  }
}

class Database {
  static final db = FirebaseFirestore.instance;

  static Future<UserModel?> getUser() async {
    final user = await db
        .collection("users")
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (val, options) => val.toFirestore())
        .doc(Auth.auth.currentUser!.uid)
        .get()
        .then((val) => val.data());
    if (kDebugMode) {
      print(Auth.auth.currentUser!.displayName);
      print(Auth.auth.currentUser!.email);
    }
    if (user == null) {
      // user is new and no data can be received from the

      final newUser = UserModel(
          id: Auth.auth.currentUser!.uid, email: Auth.auth.currentUser!.email!);

      await db
          .collection("users")
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (val, options) => val.toFirestore())
          .doc(Auth.auth.currentUser!.uid)
          .set(newUser);

      return newUser;
    }
    return user;
  }

  static Future<List<String>> getUsernames() async {
    final usernames = <String>[]; // Initialize the list

    await db
        .collection("users")
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (m, _) => m.toFirestore())
        .get()
        .then(
      (value) {
        for (var user in value.docs) {
          if (user.data().username != null) {
            usernames.add(user.data().username!);
          }
        }
      },
    );

    return usernames;
  }
}
