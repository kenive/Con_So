import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_injoy/screens/home.dart';
import 'package:game_injoy/screens/one_people/one_people.dart';
import 'package:game_injoy/screens/two_people/two_people.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnePeopleLogic(context: context)),
        ChangeNotifierProvider(create: (_) => TwoPeoPleLogic(context: context)),
      ],
      child: MaterialApp(
        title: 'Con Số',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Home(),
          '/one_people': (context) => const OnePeople(),
          '/two_people': (context) => const TwoPeoPle(),
        },
      ),
    );
  }
}
