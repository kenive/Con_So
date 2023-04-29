import 'package:game_injoy/screens/home_page/home_page.dart';
import 'package:game_injoy/screens/one_people/one_people.dart';
import 'package:game_injoy/screens/two_people/two_people.dart';
import 'package:provider/provider.dart';
import '../screens/home.dart';
import '../screens/login/login.dart';
import '../screens/splash/splash.dart';

class AppRoutes {
  static const providers = 'providers';

  //Route Names
  static const root = '/';

  //Authentication
  static const auth = '/auth';

  static const login = '/login';

  static const signUp = '/signUp';

  //App Stack
  static const appStack = '/app';

  static const homePage = '/app/home';

  static const timSo = 'timSo';

  static const tongDiem = 'tongDiem';

  static const newDetail = '/newDetail';

  static final AppRoutes _instance = AppRoutes._();

  AppRoutes._();

  factory AppRoutes() => _instance;

  static AppRoutes get instance => _instance;

  Map<String, dynamic> get routesConfig => {
        root: (_) => const Splash(),
        appStack: {
          providers: [
            ChangeNotifierProvider(
                create: (context) => HomeLogic(context: context)),
            ChangeNotifierProvider(
                create: (context) => HomePageLogic(context: context)),
            ChangeNotifierProvider(
                create: (context) => OnePeopleLogic(context: context)),
            ChangeNotifierProvider(
                create: (context) => TwoPeoPleLogic(context: context)),
          ],
          homePage: (_) => const Home(),
          timSo: (_) => const OnePeople(),
          tongDiem: (_) => const TwoPeoPle(),
        },
        auth: {
          login: (_) => const Login(),
        },
      };
}
