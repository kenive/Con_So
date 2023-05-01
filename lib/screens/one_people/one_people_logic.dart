part of 'one_people.dart';

class OnePeopleLogic extends ChangeNotifier {
  late BuildContext context;
  OnePeopleLogic({required this.context});
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
    AppColors.purpleBlueBold
  ];

  int saveSL = 0;

  int kq = 0;

  List<int> test = [];

  List<bool> checkOpen = [];

  TextEditingController txtSL = TextEditingController();

  double minSlider = 10;
  double maxSlider = 100;

  int valueSlider = 30;

  void changSlider(double value) {
    valueSlider = value.toInt();
    notifyListeners();
  }

  final random = Random();

  void timSo() {
    var provider = Provider.of<OnePeopleLogic>(context, listen: false);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            title: Text(
              'Nhập số lượng ô',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorTextBlack,
                  ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextFormField(
                //   controller: txtSL,
                //   keyboardType: TextInputType.number,
                // ),
                SizedBox(
                  width: double.infinity,
                  child: Slider(
                    min: minSlider,
                    max: maxSlider,
                    divisions: 10,
                    label: int.parse(valueSlider.toString()).toString(),
                    value: valueSlider.toDouble(),
                    onChanged: (value) {
                      changSlider(value);
                      // setState(() {
                      //   _value = value;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      'Đồng ý',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    onPressed: () {
                      // xuLyTimSo();
                      if (txtSL.text.isEmpty) {
                        Helper.showSnackBar('Không đc bỏ trống', context);
                        return;
                      }
                      startTimer();
                      xuLyRanDom(int.parse(txtSL.text));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      'Về trang chủ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      NavigationService.gotoAppStack();
                      // // txtSL.clear();
                      // Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  void xuLyRanDom(int sl) {
    checkOpen = List.filled(sl, false);
    test = List.generate(sl, (index) => index + 1);
    saveSL = sl;
    test.shuffle();
    kq = 1 + random.nextInt((sl + 1) - 1);
    notifyListeners();
  }

  void selected(int index) {
    if (checkOpen[index]) {
      return;
    }

    checkOpen[index] = true;

    if (kq == test[index]) {
      // HapticFeedback.mediumImpact();
      // SystemSound.play(SystemSoundType.click);
      timer.cancel();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.white.withOpacity(0.5),
              title: Text(
                'Bạn là người may mắn',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorTextBlack,
                    ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(
                        type: EButton.normal,
                        child: Text(
                          'Reset',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                        ),
                        onPressed: () {
                          resetTimer();
                          Navigator.of(context).pop();
                          setting(1);
                          startTimer();
                        }),
                  ),
                ],
              ),
            );
          });
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Trúng rồi')));
    }
    notifyListeners();
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
