import 'package:flutter/material.dart';
import 'package:game_injoy/themes/font_size.dart';

import '../themes/app_colors.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  final bool filled;

  final TextEditingController? controller;
  final Color? fillColor;

  final String? hideText;

  final bool checkErr;

  final bool obscureText;

  void Function()? onTap;

  final TextCapitalization textCapitalization;

  void Function(String)? onChanged;

  void Function(String)? onFieldSubmitted;

  final TextInputType? textInputType;

  final TextInputAction? textInputAction;

  final Color? colorFocused;

  final Color? errBorder;

  final bool readOnly;

  final String errText;

  final Widget? suffixIcon;

  final String label;

  TextFormFieldWidget(
      {Key? key,
      this.controller,
      this.fillColor,
      this.errBorder,
      this.textInputType,
      this.filled = true,
      this.colorFocused,
      this.textCapitalization = TextCapitalization.none,
      this.errText = '',
      this.label = '',
      this.onChanged,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.textInputAction,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.checkErr = true,
      this.hideText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label.isNotEmpty)
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.colorTextBlack,
                      ),
                ),
              )),
        TextFormField(
          textCapitalization: textCapitalization,
          scrollPadding: EdgeInsets.zero,
          onChanged: onChanged,
          keyboardType: textInputType,
          obscureText: obscureText,
          controller: controller,
          readOnly: readOnly,
          textInputAction: textInputAction,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(
          //       // RegExp("[A-Z-a-z-0-9]"),
          //       RegExp(r'^[a-z A-Z 0-9]+$')),
          // ],
          style: TextStyle(fontSize: AppFonts.font_12),
          decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              isDense: true,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: checkErr ? AppColors.primary : AppColors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.colorTextBlack, fontWeight: FontWeight.w400),
              errorText: errText,
              filled: filled,
              fillColor: fillColor ?? AppColors.white,
              hintText: hideText ?? '',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 13, top: 13),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errText.isEmpty ? AppColors.primary : AppColors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: checkErr ? AppColors.primary : AppColors.red,
                    width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: UnderlineInputBorder(
                //borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(4),
              ),
              suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
