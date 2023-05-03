import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
      "time": ' ',
      "soO": 0,
      "ngayTao": ngayTao,
      'timeUpdate': '',
    });
  }

  Future updateUser(String time, int soO) async {
    String dateFormat =
        DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
    return await userCollection.doc(uid).update({
      "time": time,
      "soO": soO,
      'timeUpdate': dateFormat,
    });
  }

  Future gettingUserData() async {
    var response = await userCollection.doc(uid).get();
    return Users.fromJson(jsonDecode(jsonEncode(response.data())));
  }
}
