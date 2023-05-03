import 'package:flutter/material.dart';
import 'package:game_injoy/helper/helper.dart';
import 'package:game_injoy/packages/update_user.dart';
import 'package:game_injoy/routes/route.dart';
import 'package:game_injoy/widgets/popup.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';
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
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.purpleBlueBold,
            title: Text(
              'Xin chào ${GetIt.instance<UserConfig>().data.name}',
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
                          popUpTimSo(context);
                        } else {
                          Navigator.pushNamed(context, AppRoutes.tongDiem);
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.2,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1.5), // changes position of shadow
                              ),
                            ],
                          ),
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
