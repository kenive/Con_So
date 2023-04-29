import 'package:flutter/widgets.dart';
import 'package:game_injoy/routes/route.dart';
import 'package:get_it/get_it.dart';

class NavigationService {
  static GlobalKey<NavigatorState>? _currentState;

  static set currentState(GlobalKey<NavigatorState> state) {
    _currentState = state;
  }

  static NavigatorState get _navState =>
      GetIt.instance.get<GlobalKey<NavigatorState>>().currentState!;

  static BuildContext get context => _navState.context;

  static Future<T?> gotoAuth<T extends Object?>([String? initRoute]) {
    return _navState.pushNamedAndRemoveUntil(
      AppRoutes.auth,
      (route) => false,
    );
  }

  // static Future<T?> introApp<T extends Object?>() {
  //   return _navState.pushNamedAndRemoveUntil(
  //     AppRoutes.intro,
  //     (route) => false,
  //   );
  // }

  static Future<T?> gotoAppStack<T extends Object?>() {
    return _navState.pushNamedAndRemoveUntil(
      AppRoutes.appStack,
      (route) => false,
    );
  }

  static void popUntil(bool Function(Route<dynamic>) predicate,
      {bool isRootNavigation = false}) {
    if (isRootNavigation) {
      _navState.popUntil(predicate);
      return;
    }
    _currentState!.currentState!.popUntil(predicate);
  }

  ///Điều hướng đến các màn hình ngoài home khi chưa đăng nhập
  static Future<T?> gotoAnotherStack<T extends Object?>(
      {required String stackPage, String? initRoute}) {
    return _navState.pushNamedAndRemoveUntil(stackPage, (route) => false,
        arguments: {'initRoute': initRoute});
  }
}
