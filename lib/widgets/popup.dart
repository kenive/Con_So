import 'package:flutter/material.dart';
import 'package:game_injoy/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';

import '../themes/app_colors.dart';

void popUpTimSo(BuildContext context) {
  var provider = Provider.of<HomePageLogic>(context, listen: false);
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      isScrollControlled: true,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: provider.txtSL,
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        'Đồng ý',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorTextBlack,
                            ),
                      ),
                      onPressed: () {
                        // provider.xuLyTimSo();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        'Đóng',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorTextBlack,
                            ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        provider.txtSL.clear();
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      context: context);
}
