import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_injoy/packages/app_vm.dart';
import 'package:game_injoy/packages/nested_navigator.dart';
import 'package:game_injoy/packages/update_user.dart';
import 'package:game_injoy/routes/route.dart';
import 'package:game_injoy/screens/login/login.dart';
import 'package:game_injoy/screens/one_people/one_people.dart';
import 'package:game_injoy/themes/themes.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'configurationDependInjection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configurationGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetIt.instance.get<AppVM>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance.get<UserConfig>(),
        ),
        ChangeNotifierProvider(create: (_) => LoginLogic(context: context)),
      ],
      child: MaterialApp(
        title: 'Con Số',
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.dark,
        theme: AppTheme.light,
        navigatorKey: GetIt.instance.get<GlobalKey<NavigatorState>>(),
        onGenerateRoute: (settings) => generateRoute(
          settings,
          AppRoutes().routesConfig,
        ),
      ),
    );
  }
}
