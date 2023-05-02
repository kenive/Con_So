import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_injoy/helper/helper.dart';
import 'package:game_injoy/themes/font_size.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../helper/firebase.dart';
import '../../packages/navigator.dart';
import '../../packages/update_user.dart';
import '../../themes/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/loadding_widget.dart';

part 'tim_so_logic.dart';

class TimSo extends StatefulWidget {
  const TimSo({super.key});

  @override
  State<TimSo> createState() => _TimSoState();
}

class _TimSoState extends State<TimSo> {
  late TimSoLogic logic;
  @override
  void initState() {
    super.initState();
    // _startTimer();

    logic = context.read<TimSoLogic>();
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
      child: Consumer<TimSoLogic>(builder: (__, value, _) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    value.timer.cancel();
                    value.resetTimer();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  )),
              elevation: 1,
              bottomOpacity: 0,
              backgroundColor: AppColors.purpleBlueBold,
              title: Text(
                'Độ khó: ${value.saveSL} ô',
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
                        // logic.setting(value);
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              'Số lần sai',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorTextBlack,
                                  ),
                            ),
                            Text(
                              '${value.soLanSai}/3',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.red,
                                      fontSize: AppFonts.font_20),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              'Số lần chọn',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorTextBlack,
                                  ),
                            ),
                            Selector<TimSoLogic, int>(
                              selector: (p0, p1) => p1.soLan,
                              builder: (context, value, child) {
                                return Text(
                                  value.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.greenLight,
                                          fontSize: AppFonts.font_20),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Selector<TimSoLogic, Tuple2<int, int>>(
                      selector: (p0, p1) => Tuple2(p1.timeGiay, p1.timePhut),
                      builder: (context, value, child) {
                        return Expanded(
                          child: Container(
                            // padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.backgroundColor),
                            child: Column(
                              children: [
                                Text(
                                  'Thời gian',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
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
                                          fontSize: AppFonts.font_20),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          'CON SỐ',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          value.kq.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                    (index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(width: 0.2, color: AppColors.black),
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
                        child: InkWell(
                          onTap: () {
                            value.selected(index);
                          },
                          child: Center(
                            // child: Text(
                            //   value.test[index].toString(),
                            //   style: TextStyle(
                            //       color: value.color[Random().nextInt(4)],
                            //       fontSize: AppFonts.font_17,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(
                                  Random().nextInt(360) / 360),
                              child: Text(
                                value.test[index].toString(),
                                style: TextStyle(
                                    color: value.color[Random().nextInt(5)],
                                    fontSize: AppFonts.font_17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
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
