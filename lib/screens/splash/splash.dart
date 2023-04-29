import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../packages/app_vm.dart';
import '../../themes/app_colors.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetIt.instance<AppVM>().middleWareHandle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset('asset/icon_app.png'))),
    );
  }
}
