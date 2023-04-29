part of 'home.dart';

class HomeLogic with ChangeNotifier {
  BuildContext context;
  HomeLogic({required this.context});
  int initHome = 0;

  PageController pageController = PageController(initialPage: 0);

  void onPageChange(int index) async {
    initHome = index;

    pageController.jumpToPage(index);

    notifyListeners();
  }

  void updateBottomTab(int index) {
    if (index != initHome) {
      onPageChange(index);
    }
  }
}
