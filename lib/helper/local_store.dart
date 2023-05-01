import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();

  //key storage
  static const String uid = 'uid';

  static const String enableIntro = 'enable_intro';

  static const String info = 'user-info';

  SharedPreferences? pref;

  SharedPreferences get store => pref!;

  LocalStorage._();

  factory LocalStorage() => _instance;

  static LocalStorage get instance => _instance;

  static Future<void> init() async {
    instance.pref ??= await SharedPreferences.getInstance();
    return Future.value();
  }

  String get uuid => store.getString(LocalStorage.uid) ?? '';

  setUuid(String uuid) {
    return store.setString(uid, uuid);
  }

  Future<bool> setFirstApp(bool checkOpen) {
    return store.setBool(LocalStorage.enableIntro, checkOpen);
  }

  bool get firstLogin => store.getBool(LocalStorage.enableIntro) ?? false;

  Future<bool> setInfoUser(Users? infoUser) {
    if (infoUser == null) {
      return store.remove(LocalStorage.info);
    }
    return store.setString(info, jsonEncode(infoUser.toJson()));
  }

  Users? get userInfo {
    String? userInfo = store.getString(info);
    if (userInfo == null) {
      return null;
    }
    return Users.fromJson(jsonDecode(userInfo));
  }

  // setFcmToken(String token) {
  //   store.setString('fcm_token', token);
  // }

  // String get fcmToken {
  //   return store.getString('fcm_token') ?? '';
  // }
}
