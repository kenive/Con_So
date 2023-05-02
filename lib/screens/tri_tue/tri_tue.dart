import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_injoy/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../cau_hoi/lst_cauhoi.dart';
import '../../helper/helper.dart';
import '../../packages/navigator.dart';
import '../../themes/app_colors.dart';

part 'tri_tue_logic.dart';

class TriTue extends StatefulWidget {
  const TriTue({super.key});

  @override
  State<TriTue> createState() => _TriTueState();
}

class _TriTueState extends State<TriTue> {
  late TriTueLogic logic;

  @override
  void initState() {
    super.initState();
    logic = TriTueLogic(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    logic.timer.cancel();
  }
  // List get arg => ModalRoute.of(context)!.settings.arguments as List;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.purpleBlueBold,
            elevation: 1,
            bottomOpacity: 0,
            leading: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white,
                          title: Text(
                            "Bạn có thật sự muốn thoát không?",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.colorTextBlack,
                                ),
                          ),
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ButtonWidget(
                                  type: EButton.normal,
                                  child: Text(
                                    'Thoát',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                        ),
                                  ),
                                  onPressed: () {
                                    logic.timer.cancel();
                                    NavigationService.gotoAppStack();
                                  }),
                              ButtonWidget(
                                  type: EButton.normal,
                                  child: Text(
                                    'Ở lại',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                )),
            actions: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 10),
              //   child: InkWell(
              //     child: PopupMenuButton(
              //       color: AppColors.white,
              //       offset: const Offset(-23, kToolbarHeight),
              //       child: const Icon(
              //         Icons.settings,
              //         color: AppColors.white,
              //         size: 30,
              //       ),
              //       onSelected: (value) {
              //         // logic.setting(value);
              //       },
              //       itemBuilder: (_) {
              //         return [
              //           const PopupMenuItem(
              //               value: 0, child: Text('Về trang chủ')),
              //           const PopupMenuItem(
              //               value: 1,
              //               child: Text(
              //                 'Reset',
              //                 style: TextStyle(),
              //               )),
              //         ];
              //       },
              //     ),
              //   ),
              // )
            ],
            title: Text(
              'Trí tuệ',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              children: [
                Selector<TriTueLogic, Tuple2<Map<String, dynamic>?, int>>(
                  selector: (p0, p1) => Tuple2(p1.dataCauHoi, p1.countCauHoi),
                  builder: (context, value, child) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: AppColors.black),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 0.5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Số điểm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                ),
                                Selector<TriTueLogic, int>(
                                  selector: (p0, p1) => p1.score,
                                  builder: (context, value, child) {
                                    return Text(
                                      value.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.red,
                                          ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Thời gian',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                ),
                                Selector<TriTueLogic, int>(
                                  selector: (p0, p1) => p1.start,
                                  builder: (context, value, child) {
                                    return Text(
                                      value.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 2,
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              'Câu ${value.item2 + 1}: ${value.item1!['cau_hoi']}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                      height: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 100 / 20,
                            crossAxisCount: 2,
                          ),
                          children: List.generate(
                            value.item1!['dap_an'].length,
                            (index) => Selector<TriTueLogic, bool>(
                              selector: (p0, p1) => p1.checkDapAn[index],
                              builder: (context, val, child) {
                                return InkWell(
                                  onTap: () {
                                    if (logic.selected || logic.start == 0) {
                                      return;
                                    }
                                    logic.selectedDapAn(
                                        value.item1!['dap_an'][index]['status'],
                                        index);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: val
                                              ? AppColors.greenLight
                                              : AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 0.2,
                                              color: AppColors.black)),
                                      child: Center(
                                        child: Text(
                                          value.item1!['dap_an'][index]['name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black,
                                              ),
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                        ),
                        Selector<TriTueLogic, Tuple2<bool, String>>(
                            selector: (p0, p1) => Tuple2(p1.selected, p1.title),
                            builder: (context, val, child) {
                              if (val.item2.isNotEmpty) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ButtonWidget(
                                        type: EButton.normal,
                                        primary:
                                            val.item1 ? null : AppColors.grey,
                                        onPressed: () {
                                          if (val.item1) {
                                            logic.chonLai();
                                          }
                                        },
                                        child: Text(
                                          'Chọn lại',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white,
                                              ),
                                        )),
                                    ButtonWidget(
                                        type: EButton.normal,
                                        primary: val.item1
                                            ? AppColors.primary
                                            : AppColors.grey,
                                        onPressed: () {
                                          // logic.tiepTuc();
                                          if (val.item1) {
                                            logic.tiepTuc();
                                          }
                                        },
                                        child: Text(
                                          'Đồng ý',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white,
                                              ),
                                        ))
                                  ],
                                ),
                              );
                            })
                      ]),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Selector<TriTueLogic, Tuple3<int, String, int>>(
                  selector: (p0, p1) => Tuple3(p1.kq, p1.title, p1.score),
                  builder: (context, value, child) {
                    if (value.item1 == 0 && value.item2.isNotEmpty) {
                      return Column(
                        children: [
                          Text(
                            value.item2,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.colorTextBlack,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tổng điểm: ${value.item3}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorTextBlack,
                                  ),
                            ),
                          ),
                          ButtonWidget(
                              child: Text(
                                'Chơi lại',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                              ),
                              onPressed: () {
                                logic.xuLyCauHoi();
                                logic.timeReset();
                                logic.chonLai();
                              }),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                )
              ],
            ),
          )),
    );
  }
}
