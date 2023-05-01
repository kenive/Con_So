import 'package:flutter/material.dart';
import 'package:game_injoy/model/user.dart';

import '../helper/local_store.dart';

class UserConfig with ChangeNotifier {
  Users data = Users.userEmpty;
  UserConfig() {
    _initData();
  }

  void _initData() async {
    data = LocalStorage().userInfo ?? Users.userEmpty;
    notifyListeners();
  }

  void updateInfo(Users info) {
    data = info;

    LocalStorage().setInfoUser(data);

    notifyListeners();
  }

  void reset() {
    data = Users.userEmpty;
    notifyListeners();
  }
}
