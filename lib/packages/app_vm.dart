import 'package:flutter/material.dart';

import '../helper/firebase.dart';
import '../helper/local_store.dart';
import '../packages/navigator.dart';

enum AuthState { noLogin, login }

class AppVM with ChangeNotifier {
  AuthState authState = AuthState.noLogin;

  bool get isLogin => authState == AuthState.login;

  Future<void> middleWareHandle() async {
    await LocalStorage.init();

    LocalStorage storage = LocalStorage();

    if (storage.uuid.isNotEmpty) {
      try {
        authState = AuthState.login;
        NavigationService.gotoAppStack();
        notifyListeners();
      } catch (e) {
        debugPrint('$e');
      }
    } else {
      authState = AuthState.noLogin;
      NavigationService.gotoAuth();
    }
  }

  void loginSuccess(String uuid) async {
    // Save token
    await LocalStorage().setUuid(uuid);

    authState = AuthState.login;

    notifyListeners();
    // diều hướng vào màn hình trang chủ
    NavigationService.gotoAppStack();
  }

  void logout() {
    authState = AuthState.noLogin;

    LocalStorage().setUuid('');

    AuthService().signOut();

    NavigationService.gotoAuth();
    notifyListeners();
  }
}
