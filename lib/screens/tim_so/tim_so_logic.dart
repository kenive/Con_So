part of 'tim_so.dart';

class TimSoLogic extends ChangeNotifier {
  late BuildContext context;
  TimSoLogic({required this.context});
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   timSo();
  //   // popUpTimSo(context);
  // });

  late Timer timer;

  int timeGiay = 0;

  int timePhut = 0;

  void resetTimer() {
    timeGiay = 0;
    timePhut = 0;
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeGiay++;
      if (timeGiay == 60) {
        timeGiay = 0;
        timePhut++;
      }
      notifyListeners();
    });
  }

  List color = [
    AppColors.red,
    AppColors.black,
    AppColors.primary,
    AppColors.purpleBlueBold,
    AppColors.greenLight
  ];

  int saveSL = 0;

  int kq = 0;

  List<int> test = [];

  double minSlider = 10;

  double maxSlider = 100;

  int valueSlider = 30;

  void changSlider(double value) {
    valueSlider = value.toInt();
    notifyListeners();
  }

  final random = Random();

  void xuLyRanDom(int sl) {
    test = List.generate(sl, (index) => index + 1);
    saveSL = sl;
    test.shuffle();
    soLan = 5;
    soLanSai = 0;
    kq = 1 + random.nextInt((sl + 1) - 1);
    notifyListeners();
  }

  int soLan = 5;

  int soLanSai = 0;
  void selected(int index) {
    if (kq == test[index]) {
      --soLan;
      if (soLan == 0) {
        timer.cancel();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColors.white,
                title: Text(
                  'Bạn đã chiến thắng',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorTextBlack,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (GetIt.instance<UserConfig>().data.time.isNotEmpty)
                      Text(
                        'Lần lưu gần nhất: ${GetIt.instance<UserConfig>().data.time}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorTextBlack,
                            ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Thời gian chơi: $timePhut : $timeGiay',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                        child: Text(
                          'Chơi lại',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setting(1);
                        }),
                    ButtonWidget(
                        child: Text(
                          'Lưu lại',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                        ),
                        onPressed: () async {
                          // Navigator.of(context).pop();
                          // setting(1);
                          await DatabaseService(
                                  uid: GetIt.instance<UserConfig>().data.uid)
                              .updateUser('$timePhut:$timeGiay', saveSL);
                          NavigationService.gotoAppStack();
                        }),
                    ButtonWidget(
                        child: Text(
                          'Thoát',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                        ),
                        onPressed: () {
                          NavigationService.gotoAppStack();
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            });
        notifyListeners();
        return;
      }
      Loading.show();
      test.shuffle();
      kq = 1 + random.nextInt((saveSL + 1) - 1);
      // HapticFeedback.mediumImpact();
      // SystemSound.play(SystemSoundType.click);
      Helper.showToast('Trúng rồi, tiếp tục chọn nào.', context);
      Loading.hide();
    } else {
      Loading.show();
      soLanSai++;
      --soLan;
      if (soLan == 0) {
        return;
      }
      if (soLanSai == 3) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColors.white,
                title: Text(
                  'Thua rồi, bạn đã chọn sai quá 2 lần',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorTextBlack,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Thời gian chơi: $timePhut : $timeGiay',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonWidget(
                          type: EButton.normal,
                          child: Text(
                            'Chơi lại',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setting(1);
                          }),
                    ),
                  ],
                ),
              );
            });

        timer.cancel();
        notifyListeners();
        Loading.hide();

        return;
      }
      test.shuffle();
      kq = 1 + random.nextInt((saveSL + 1) - 1);
      Loading.hide();
    }
  }

  void setting(int index) {
    if (index == 1) {
      resetTimer();
      startTimer();
      xuLyRanDom(saveSL);
      return;
    }
  }
}
