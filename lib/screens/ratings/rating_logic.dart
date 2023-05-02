part of 'rating.dart';

class RatingLogic with ChangeNotifier {
  BuildContext context;
  RatingLogic({required this.context}) {
    getUsers();
  }

  List<QueryDocumentSnapshot<Object?>> getUser = [];

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  void getUsers() async {
    await userCollection.get().then((value) {
      getUser = value.docs;
      notifyListeners();
    });
  }
}
