import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    _auth.signOut();
  }
}

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future savingUserData(String email, String name, String ngayTao) async {
    return await userCollection.doc(uid).set({
      "name": name,
      "email": email,
      "uid": uid,
      "score": 0,
      // "timeEnd": '',
      "ngayTao": ngayTao,
    });
  }

  Future gettingUserData() async {
    var response = await userCollection.doc(uid).get();
    return Users.fromJson(jsonDecode(jsonEncode(response.data())));
  }
}
