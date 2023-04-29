import 'dart:io';

import 'package:flutter/material.dart';

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
}
