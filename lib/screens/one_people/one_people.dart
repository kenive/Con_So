import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_injoy/helper/helper.dart';
import 'package:game_injoy/screens/home.dart';
import 'package:game_injoy/themes/font_size.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../packages/navigator.dart';
import '../../themes/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/popup.dart';

part 'one_people_logic.dart';

class OnePeople extends StatefulWidget {
  const OnePeople({super.key});

  @override
  State<OnePeople> createState() => _OnePeopleState();
}

class _OnePeopleState extends State<OnePeople> {
  late OnePeopleLogic logic;
  @override
  void initState() {
    super.initState();
    // _startTimer();

    logic = context.read<OnePeopleLogic>();
  }

  @override
  void dispose() {
    logic.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Consumer<OnePeopleLogic>(builder: (__, value, _) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    value.timer.cancel();
                    value.resetTimer();
                    ;
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  )),
              elevation: 1,
              bottomOpacity: 0,
              backgroundColor: AppColors.purpleBlueBold,
              title: Text(
                'Tìm số',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    child: PopupMenuButton(
                      color: AppColors.white,
                      offset: const Offset(-23, kToolbarHeight),
                      child: const Icon(
                        Icons.settings,
                        color: AppColors.white,
                        size: 30,
                      ),
                      onSelected: (value) {
                        logic.setting(value);
                      },
                      itemBuilder: (_) {
                        return [
                          PopupMenuItem(
                              value: 0,
                              child: Text(
                                'Trang chủ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorTextBlack,
                                    ),
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: Text(
                                'Reset',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorTextBlack,
                                    ),
                              )),
                        ];
                      },
                    ),
                  ),
                ),
                // IconButton(onPressed: () {}, icon: Icon(Icons.settings))
              ]),
          backgroundColor: AppColors.white,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          'Con số',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorTextBlack,
                                  ),
                        ),
                        Text(
                          value.kq.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.colorTextBlack,
                                  fontSize: AppFonts.font_20),
                        )
                      ],
                    ),
                  ),
                  Selector<OnePeopleLogic, Tuple2<int, int>>(
                    selector: (p0, p1) => Tuple2(p1.timeGiay, p1.timePhut),
                    builder: (context, value, child) {
                      return Container(
                        padding: const EdgeInsets.all(25),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.backgroundColor),
                        child: Column(
                          children: [
                            Text(
                              'Thời gian',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorTextBlack,
                                  ),
                            ),
                            Text(
                              '${value.item2} : ${value.item1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 100 / 70,
                    crossAxisCount: 5,
                  ),
                  children: List.generate(
                    value.test.length,
                    (index) => InkWell(
                      onTap: () {
                        value.selected(index);
                      },
                      child: Selector<OnePeopleLogic, List<bool>>(
                          selector: (p0, p1) => p1.checkOpen,
                          builder: (_, val, __) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: val[index] &&
                                            value.kq == value.test[index]
                                        ? AppColors.greenLight
                                        : AppColors.backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.2, color: AppColors.black)),
                                child: Center(
                                  child: Text(
                                    val[index]
                                        ? value.test[index].toString()
                                        : '',
                                    style: TextStyle(
                                        color: value.color[Random().nextInt(4)],
                                        fontSize: AppFonts.font_17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));
                          }),
                    ),
                  ),
                ),
              )
            ]),
          ),
        );
      }),
    );
  }
}
