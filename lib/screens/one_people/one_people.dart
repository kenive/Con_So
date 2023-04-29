import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_injoy/helper/helper.dart';
import 'package:provider/provider.dart';

import '../../packages/navigator.dart';
import '../../themes/app_colors.dart';

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
    logic = OnePeopleLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Consumer<OnePeopleLogic>(builder: (context, value, _) {
        return Scaffold(
          appBar: AppBar(
              elevation: 1,
              bottomOpacity: 0,
              backgroundColor: AppColors.purpleBlueBold,
              title: Text(
                'Tìm số ngẫu nhiên',
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
                ),
                // IconButton(onPressed: () {}, icon: Icon(Icons.settings))
              ]),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              if (value.kq != 0) ...[
                const Text(
                  'Con số cần tìm',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  value.kq.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              GridView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 100 / 70,
                  crossAxisCount: 4,
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
                                      ? AppColors.primary
                                      : AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.2, color: AppColors.black)),
                              child: Center(
                                child: Text(
                                  val[index]
                                      ? value.test[index].toString()
                                      : '',
                                  style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ));
                        }),
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
