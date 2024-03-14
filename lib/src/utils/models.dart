import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? username;
  final String? name;
  final String email;
  final String? universityId;

  UserModel(
      {required this.id,
      required this.email,
      this.name,
      this.universityId,
      this.username});

factory
  UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
    final data = snapshot.data();

    final fromFirebase = UserModel(
        id: data?['id'],
        email: data?['email'],
        username: data?['username'],
        name: data?['name'],
        universityId: data?['universityId']);

    return fromFirebase;
  }
  Map<String, dynamic> toFirestore() {
    return {
      "email": email,
      if (username != null) "username": username,
      if (name != null) "name": name,
      if (universityId != null) "universityId": universityId
    };
  }
}
