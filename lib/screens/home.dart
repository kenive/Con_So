import 'package:flutter/material.dart';
import 'package:game_injoy/screens/home_page/home_page.dart';
import 'package:game_injoy/screens/ratings/rating.dart';
import 'package:game_injoy/screens/setting/setting.dart';
import 'package:game_injoy/themes/app_colors.dart';

import 'package:provider/provider.dart';

import 'bottom_navigator/bottom_navigator.dart';
part 'home_logic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pageList = [
    const HomePage(),
    const Rating(),
    const Setting(),
  ];

  late HomeLogic logic;

  @override
  void initState() {
    super.initState();
    logic = HomeLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.backgroundColor,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: logic.pageController,
            children: pageList,
          ),
          bottomNavigationBar: Selector<HomeLogic, int>(
            selector: (p0, p1) => p1.initHome,
            builder: (context, value, child) {
              return BottomNavigation(
                index: value,
                onTap: logic.updateBottomTab,
              );
            },
          )),
    );
  }
}
