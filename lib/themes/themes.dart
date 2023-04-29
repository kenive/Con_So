import 'package:flutter/material.dart';
import 'package:game_injoy/themes/text_themes.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get _baseTheme {
    return ThemeData(
      textTheme: AppTextTheme(mode: ThemeMode.light).buildTextTheme(),
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primary,
      primaryColorDark: AppColors.primary.withOpacity(0.4),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.black,
        selectionColor: AppColors.primary.withOpacity(0.5),
        // selectionHandleColor: AppColors.sliver,
      ),
      brightness: Brightness.dark,
      indicatorColor: AppColors.secondary,
      hintColor: AppColors.black,
      // dividerTheme: const DividerThemeData(color: AppColors.sliver),
      // dividerColor: AppColors.sliver,
      // cardColor: AppColors.lightGray,
      // disabledColor: AppColors.gray,
      bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.white),
      // scaffoldBackgroundColor: AppColors.white,
      // scaffoldBackgroundColor: AppColors.textLightGrayBG,
      unselectedWidgetColor: AppColors.black,
      shadowColor: Colors.grey[100],
      colorScheme: const ColorScheme.light(
        primary: MaterialColor(0xFF00B4D8, {50: Color(0xFF00B4D8)}),
        secondary: AppColors.secondary,
        background: Colors.white,
        brightness: Brightness.dark,
      ).copyWith(background: AppColors.backgroundColor),
    );
  }

  static ThemeData get light {
    return _baseTheme;
  }

  static ThemeData get dark {
    return _baseTheme.copyWith(
      textTheme: AppTextTheme(mode: ThemeMode.light).buildTextTheme(),
    );
  }
}
