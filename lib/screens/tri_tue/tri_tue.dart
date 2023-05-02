import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_injoy/helper/lst_cauhoi.dart';
import 'package:game_injoy/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                )),
            actions: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        'Số điểm',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                      ),
                      Text(
                        '1000',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              )

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
            padding: const EdgeInsets.all(10),
            child: Selector<TriTueLogic, Tuple2<Map<String, dynamic>?, int>>(
              selector: (p0, p1) => Tuple2(p1.dataCauHoi, p1.id),
              builder: (context, value, child) {
                return Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.black)),
                    child: Center(
                      child: Column(
                         
                          children: [
                            Text(
                              value.item1!['cau_hoi'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorTextBlack,
                                  ),
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
                                (index) => InkWell(
                                  onTap: () {
                                    // value.selected(index);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
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
                                                color: AppColors.white,
                                              ),
                                        ),
                                        // child: Text(
                                        //   value[0]['dap_an'][index]['name'],
                                        //   style: const TextStyle(
                                        //       color: AppColors.black,
                                        //       fontSize: 18,
                                        //       fontWeight: FontWeight.w700),
                                        // ),
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
                            ButtonWidget(
                                onPressed: () {
                                  logic.tiepTuc(++logic.id);
                                },
                                child: Text(
                                  'Tiếp tục',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                ))
                          ]),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
