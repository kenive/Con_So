import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future savingUserData(String email) async {
    return await userCollection.doc(uid).set({
      "email": email,
      "uid": uid,
    });
  }
}
