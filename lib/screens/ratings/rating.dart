import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game_injoy/themes/font_size.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';
part 'rating_logic.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late RatingLogic logic;
  @override
  void initState() {
    super.initState();
    logic = RatingLogic(context: context);
  }

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
          title: Text(
            'Xếp hạng',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Selector<RatingLogic, List<QueryDocumentSnapshot<Object?>>>(
            selector: (p0, p1) => p1.getUser,
            builder: (context, value, child) {
              return Column(
                children: List.generate(value.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: PhysicalModel(
                      color: AppColors.white,
                      elevation: 2,
                      shadowColor: AppColors.greenLight,
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        dense: true,
                        minVerticalPadding: 10,
                        horizontalTitleGap: 25,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            'Thời gian: ${value[index]['time']}',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorTextBlack,
                                    ),
                          ),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${value[index]['soO']} ô ',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorTextBlack,
                                    ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Gần nhất: ${value[index]['timeUpdate']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorTextBlack,
                                      fontSize: AppFonts.font10)),
                        ),
                        title: Text(
                          'Tên: ${value[index]['name']}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorTextBlack,
                                  ),

                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     ListtTile(
                          //       title: Text(
                          //         'Tên: ${value[index]['name']}',
                          //         style:
                          //             Theme.of(context).textTheme.bodyLarge!.copyWith(
                          //                   fontWeight: FontWeight.bold,
                          //                   color: AppColors.colorTextBlack,
                          //                 ),
                          //       ),
                          //     ),
                          //     // Padding(
                          //     //   padding: const EdgeInsets.symmetric(vertical: 5),
                          //     //   child: Text(
                          //     //     'Độ khó: ${value[index]['soO']} ô ',
                          //     //     style:
                          //     //         Theme.of(context).textTheme.bodyLarge!.copyWith(
                          //     //               fontWeight: FontWeight.bold,
                          //     //               color: AppColors.colorTextBlack,
                          //     //             ),
                          //     //   ),
                          //     // ),
                          //     // Text(
                          //     //   'Thời gian: ${value[index]['time']}',
                          //     //   style:
                          //     //       Theme.of(context).textTheme.bodyLarge!.copyWith(
                          //     //             fontWeight: FontWeight.bold,
                          //     //             color: AppColors.colorTextBlack,
                          //     //           ),
                          //     // ),
                          //     // Padding(
                          //     //   padding: const EdgeInsets.symmetric(vertical: 5),
                          //     //   child: Text(
                          //     //     'Cập nhật gần nhất: ${value[index]['timeUpdate']}',
                          //     //     style:
                          //     //         Theme.of(context).textTheme.bodyLarge!.copyWith(
                          //     //               fontWeight: FontWeight.bold,
                          //     //               color: AppColors.colorTextBlack,
                          //     //             ),
                          //     //   ),
                          //     // )
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
