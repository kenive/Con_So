import 'package:flutter/material.dart';
import 'package:game_injoy/helper/helper.dart';
import 'package:game_injoy/routes/route.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';
import '../../widgets/popup.dart';
part 'home_page_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageLogic logic;

  @override
  void initState() {
    super.initState();
    logic = HomePageLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: logic,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.purpleBlueBold,
            title: Text(
              'Danh mục',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ),
          body: GridView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 100 / 30,
              crossAxisCount: 2,
            ),
            children: List.generate(
                logic.item.length,
                (index) => InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.pushNamed(context, AppRoutes.timSo);
                        } else {
                          // logic.tongDiem();
                          Navigator.pushNamed(context, AppRoutes.tongDiem);
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              logic.item[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorTextBlack,
                                  ),
                            ),
                          )),
                    )),
          ),
        ));
  }
}
