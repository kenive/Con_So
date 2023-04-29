import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextTheme {
  final ThemeMode mode;
  AppTextTheme({this.mode = ThemeMode.light});

  TextTheme buildTextTheme() {
    return TextTheme(
      bodyLarge: _bodyLarge,
      bodyMedium: _bodyMedium,
      titleMedium: _titleMedium,
      titleSmall: _titleSmall,
    );
  }

  static double scaleFontSize(double size) {
    return size + 1;
  }

  // TextStyle get _overline {
  //   return _colorTextBase.copyWith(
  //     fontSize: scaleFontSize(10),
  //   );
  // }

  // TextStyle get _headerLine6 {
  //   return _colorTextBase.copyWith(
  //     fontSize: scaleFontSize(22),
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // TextStyle get _headerLine5 =>
  //     TextStyle(fontSize: scaleFontSize(34), fontWeight: FontWeight.bold)
  //         .merge(_colorTextBase);

  // TextStyle get _headerLine4 {
  //   return _colorTextBase.copyWith(
  //     fontSize: scaleFontSize(22),
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // TextStyle get _caption =>
  //     TextStyle(fontSize: scaleFontSize(20), fontWeight: FontWeight.bold)
  //         .merge(_colorTextBase);

  TextStyle get _bodyLarge => TextStyle(
        fontSize: scaleFontSize(12),
      ).merge(_colorTextBase);

  TextStyle get _bodyMedium => TextStyle(
        fontSize: scaleFontSize(14),
      ).merge(_colorTextBase);

  TextStyle get _titleMedium => TextStyle(
        fontSize: scaleFontSize(16),
      ).merge(_colorTextBase);

  TextStyle get _titleSmall {
    return TextStyle(
      fontSize: scaleFontSize(18),
      fontWeight: FontWeight.bold,
    ).merge(_colorTextBase);
  }

  TextStyle get _colorTextBase {
    if (mode == ThemeMode.dark) {
      return GoogleFonts.montserrat(color: AppColors.white);
    }

    return GoogleFonts.montserrat(color: AppColors.colorTextBlack);
  }
}
