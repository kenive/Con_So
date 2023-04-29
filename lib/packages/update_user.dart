import 'package:flutter/material.dart';

import '../helper/local_store.dart';

class UserConfig with ChangeNotifier {
  String data = '';
  UserConfig() {
    _initData();
  }

  void _initData() async {
    data = LocalStorage().uuid;
    notifyListeners();
  }

  void updateInfo(String uuid) {
    data = uuid;
    notifyListeners();

    LocalStorage().setUuid(data);
  }

  void reset() {
    data = '';
    notifyListeners();
  }
}
