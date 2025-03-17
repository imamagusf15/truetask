import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photo;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.photo,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: snapshot.id,
      name: data?['name'],
      email: data?['email'],
      photo: data?['photo'],
    );
  }

  factory UserModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      photo: data['photo'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      "photo": photo,
    };
  }
}
