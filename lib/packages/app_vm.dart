import 'package:flutter/material.dart';
import 'package:game_injoy/packages/update_user.dart';
import 'package:get_it/get_it.dart';

import '../helper/firebase.dart';
import '../helper/local_store.dart';
import '../packages/navigator.dart';

enum AuthState { noLogin, login }

class AppVM with ChangeNotifier {
  AuthState authState = AuthState.noLogin;

  bool get isLogin => authState == AuthState.login;

  LocalStorage storage = LocalStorage();

  Future<void> middleWareHandle() async {
    await LocalStorage.init();

    if (storage.uuid.isNotEmpty) {
      try {
        authState = AuthState.login;
        DatabaseService(uid: storage.uuid).gettingUserData().then((value) {
          GetIt.instance<UserConfig>().updateInfo(value);
          NavigationService.gotoAppStack();
          notifyListeners();
        });
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

    DatabaseService(uid: uuid).gettingUserData().then((value) async {
      GetIt.instance<UserConfig>().updateInfo(value);
      await LocalStorage().setUuid(uuid);

      authState = AuthState.login;

      // diều hướng vào màn hình trang chủ
      NavigationService.gotoAppStack();
      notifyListeners();
    });
  }

  void logout() {
    authState = AuthState.noLogin;

    LocalStorage().setUuid('');

    storage.setInfoUser(null);

    AuthService().signOut();

    NavigationService.gotoAuth();

    notifyListeners();
  }
}
