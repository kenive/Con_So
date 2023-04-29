import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

enum EButton {
  full,
  normal,
}

class ButtonWidget extends StatelessWidget {
  final Function() onPressed;

  final Color? primary;

  final EButton type;

  final Widget child;

  final double? elevation;

  final BorderSide side;

  final EdgeInsetsGeometry? padding;

  const ButtonWidget(
      {Key? key,
      required this.onPressed,
      this.primary,
      required this.child,
      this.padding,
      this.elevation,
      this.side = BorderSide.none,
      this.type = EButton.full})
      : super(key: key);

  Widget button() => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: primary ?? AppColors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), side: side),
            padding: padding ?? const EdgeInsets.symmetric(vertical: 10)),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return type == EButton.normal
        ? button()
        : Row(
            children: [
              Expanded(child: button()),
            ],
          );
  }
}
