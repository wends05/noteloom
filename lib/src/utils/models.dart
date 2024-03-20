import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  final String id;
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

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
    final data = snapshot.data();
    final id = snapshot.id;

    final fromFirebase = UserModel(
        id: id,
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

class UniversityModel {
  final String? id;
  final String name;
  final String domain;
  final String? storageLogoPath;
  final List<String>? subjectIds;
  final List<String>? departmentIds;

  UniversityModel(
      {required this.id,
      required this.name,
      required this.domain,
      this.storageLogoPath,
      this.subjectIds,
      this.departmentIds});
  factory UniversityModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
    final data = snapshot.data();
    final id = snapshot.id;

    final university = UniversityModel(
        id: id,
        name: data?['name'],
        domain: data?['domain'],
        storageLogoPath: data?['storageLogoPath'],
        subjectIds: data?['subjectIds']?.cast<String>(),
        departmentIds: data?['departmentIds']?.cast<String>());

    return university;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "domain": domain,
      if (storageLogoPath != null) "storageLogoPath": storageLogoPath,
      if (subjectIds != null) "subjectIds": subjectIds,
      if (departmentIds != null) "departmentIds": departmentIds
    };
  }
}
