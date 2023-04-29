import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:game_injoy/packages/app_vm.dart';
import 'package:game_injoy/widgets/button_widget.dart';
import 'package:get_it/get_it.dart';

import '../../packages/navigator.dart';
import '../../themes/app_colors.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.purpleBlueBold,
        elevation: 1,
        bottomOpacity: 0,
        title: Text(
          'Cài đặt',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
        ),
      ),
      body: Center(
          child: ButtonWidget(
        type: EButton.normal,
        onPressed: () {
          GetIt.instance<AppVM>().isLogin
              ? GetIt.instance<AppVM>().logout()
              : NavigationService.gotoAuth();
        },
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          GetIt.instance<AppVM>().isLogin ? 'Đăng xuất' : 'Đăng nhập',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
        ),
      )),
    );
  }
}
