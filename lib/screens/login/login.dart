import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_injoy/helper/helper.dart';
import 'package:game_injoy/packages/app_vm.dart';
import 'package:game_injoy/themes/app_colors.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper/firebase.dart';
import '../../packages/navigator.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input_widget.dart';
import '../../widgets/loadding_widget.dart';

part 'login_logic.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginLogic logic;
  @override
  void initState() {
    super.initState();

    logic = LoginLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.purpleBlueBold,
            elevation: 1,
            title: Text(
              'VUI VẺ NÀO !',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('asset/icon_app.png'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Đăng nhập',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                  ),
                  TextFormFieldWidget(
                    label: 'Email',
                    hideText: 'Vui lòng nhập email',
                    controller: logic.txtEmail,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Selector<LoginLogic, bool>(
                    selector: (p0, p1) => p1.checkShowPass,
                    builder: (context, value, child) {
                      return TextFormFieldWidget(
                        label: 'Mật khẩu',
                        hideText: 'Vui lòng nhập mật khẩu',
                        controller: logic.txtMatKhau,
                        obscureText: value,
                        suffixIcon: InkWell(
                            onTap: () {
                              logic.showPass();
                            },
                            child: Icon(
                              value ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.black,
                              size: 20,
                            )),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonWidget(
                    // type: EButton.normal,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      logic.login();
                    },
                    child: Text(
                      'Đăng nhập',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: Text(
                  //     'Hoặc',
                  //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //           fontWeight: FontWeight.bold,
                  //           color: AppColors.colorTextBlack,
                  //         ),
                  //   ),
                  // ),
                  // ButtonWidget(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   onPressed: () {
                  //     NavigationService.gotoAppStack();
                  //   },
                  //   child: Text(
                  //     'Chơi ngay',
                  //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //           fontWeight: FontWeight.bold,
                  //           color: AppColors.white,
                  //         ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nếu chưa có tài khoản?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.colorTextBlack,
                                  ),
                        ),
                        InkWell(
                          onTap: () {
                            var provider =
                                Provider.of<LoginLogic>(context, listen: false);

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
                                    child: AlertDialog(
                                      backgroundColor: AppColors.white,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Đăng ký',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.colorTextBlack,
                                                ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                logic.clearDangKy();
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                size: 30,
                                                color: AppColors.black,
                                              ))
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormFieldWidget(
                                            label: 'Tên',
                                            hideText: 'Vui lòng nhập tên',
                                            controller: logic.txtName,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormFieldWidget(
                                            label: 'Email',
                                            hideText: 'Vui lòng nhập email',
                                            controller: logic.txtEmailDangKy,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Selector<LoginLogic, bool>(
                                            selector: (p0, p1) =>
                                                p1.checkShowPass,
                                            builder: (context, value, child) {
                                              return TextFormFieldWidget(
                                                label: 'Mật khẩu',
                                                hideText:
                                                    'Vui lòng nhập mật khẩu',
                                                controller:
                                                    logic.txtMatKhauDangKy,
                                                obscureText: value,
                                                suffixIcon: InkWell(
                                                    onTap: () {
                                                      provider.showPass();
                                                    },
                                                    child: Icon(
                                                      value
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: AppColors.black,
                                                      size: 20,
                                                    )),
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ButtonWidget(
                                            onPressed: () {
                                              logic.dangKy();
                                            },
                                            child: Text(
                                              'Đăng ký',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            'Đăng ký',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorTextBlack,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
