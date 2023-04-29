import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/helper.dart';
import '../../packages/navigator.dart';
import '../../themes/app_colors.dart';
part 'two_people_logic.dart';

class TwoPeoPle extends StatefulWidget {
  const TwoPeoPle({super.key});

  @override
  State<TwoPeoPle> createState() => _TwoPeoPleState();
}

class _TwoPeoPleState extends State<TwoPeoPle> {
  late TwoPeoPleLogic logic;

  @override
  void initState() {
    super.initState();
    logic = TwoPeoPleLogic(context: context);
  }

  // List get arg => ModalRoute.of(context)!.settings.arguments as List;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Consumer<TwoPeoPleLogic>(
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                backgroundColor: AppColors.purpleBlueBold,
                elevation: 1,
                bottomOpacity: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      child: PopupMenuButton(
                        color: AppColors.white,
                        offset: const Offset(-23, kToolbarHeight),
                        child: const Icon(
                          Icons.settings,
                          color: AppColors.black,
                          size: 30,
                        ),
                        onSelected: (value) {
                          // logic.setting(value);
                        },
                        itemBuilder: (_) {
                          return [
                            const PopupMenuItem(
                                value: 0, child: Text('Về trang chủ')),
                            const PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Reset',
                                  style: TextStyle(),
                                )),
                          ];
                        },
                      ),
                    ),
                  )
                ],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          value.nameUser1,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Điểm: ${value.scoreUser1}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                      'VS',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Text(
                          value.nameUser2,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Điểm: ${value.scoreUser2}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GridView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 100 / 70,
                          crossAxisCount: 4,
                        ),
                        children: List.generate(
                          value.lstRandom.length,
                          (index) => InkWell(
                            onTap: () {
                              value.selected(index);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: value.user[0] &&
                                            value.checkOpen[index] &&
                                            value.user1.contains(index)
                                        ? AppColors.red
                                        : value.user[1] &&
                                                value.checkOpen[index] &&
                                                value.user2.contains(index)
                                            ? AppColors.primary
                                            : AppColors.backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.2, color: AppColors.black)),
                                child: Center(
                                  child: Text(
                                    value.checkOpen[index]
                                        ? value.lstRandom[index].toString()
                                        : '',
                                    style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            // child: Selector<OnePeopleLogic, List<bool>>(
                            //     selector: (p0, p1) => p1.checkOpen,
                            //     builder: (_, val, __) {
                            //       return Container(
                            //           decoration: BoxDecoration(
                            //               color:
                            //                   val[index] && value.kq == value.test[index]
                            //                       ? AppColors.primary
                            //                       : AppColors.backgroundColor,
                            //               borderRadius: BorderRadius.circular(10),
                            //               border: Border.all(
                            //                   width: 0.2, color: AppColors.black)),
                            //           child: Center(
                            //             child: Text(
                            //               val[index] ? value.test[index].toString() : '',
                            //               style: const TextStyle(
                            //                   color: AppColors.black,
                            //                   fontSize: 15,
                            //                   fontWeight: FontWeight.w500),
                            //             ),
                            //           ));
                            //     }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ]),
              ));
        },
      ),
    );
  }
}
