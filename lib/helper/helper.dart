import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_injoy/themes/font_size.dart';

import '../themes/app_colors.dart';

class Helper {
  static double heightInsets(BuildContext context) {
    double insets = MediaQuery.of(context).viewPadding.bottom;
    double extraHeight = insets > 0 ? 10 : 0;

    return Platform.isIOS ? extraHeight : insets;
  }

  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
      )),
    );
  }

  static void showToast(String message, BuildContext context,
      {ToastGravity garViTy = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: garViTy,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.purpleBlueBold,
      textColor: AppColors.white,
      fontSize: AppFonts.font_15,
    );
  }
}
