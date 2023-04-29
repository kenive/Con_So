import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../themes/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final void Function(int index) onTap;
  final int index;
  const BottomNavigation({
    Key? key,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      backgroundColor: AppColors.white,
      currentIndex: index,
      onTap: onTap,
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: Text(
            'Trang chủ',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.purpleBlueBold,
                ),
          ),
          selectedColor: AppColors.purpleBlueBold,
          unselectedColor: AppColors.cursorColor,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.settings),
          title: Text(
            'Cài đặt',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.purpleBlueBold,
                ),
          ),
          selectedColor: AppColors.purpleBlueBold,
          unselectedColor: AppColors.cursorColor,
        ),
      ],
    );
  }
}
