import 'package:flutter/material.dart';
import 'package:game_injoy/packages/app_vm.dart';
import 'package:game_injoy/packages/update_user.dart';
import 'package:get_it/get_it.dart';

Future<void> configurationGetIt() async {
  var getIt = GetIt.instance;

  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey());
  getIt.registerLazySingleton<AppVM>(() => AppVM());
  getIt.registerLazySingleton<UserConfig>(() => UserConfig());

  return Future.value();
}
