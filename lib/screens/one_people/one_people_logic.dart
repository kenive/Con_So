part of 'one_people.dart';

class OnePeopleLogic extends ChangeNotifier {
  late BuildContext context;
  OnePeopleLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timSo();
    });
  }

  int saveSL = 0;

  int kq = 0;

  List<int> test = [];

  List<bool> checkOpen = [];
  TextEditingController txtSL = TextEditingController();

  final random = Random();
  void timSo() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            title: Text(
              'Nhập số lượng ô',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorTextBlack,
                  ),
            ),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: txtSL,
                    keyboardType: TextInputType.number,
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
      HapticFeedback.mediumImpact();
      SystemSound.play(SystemSoundType.click);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Bạn là người may mắn'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        child: const Text("Reset"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setting(1);
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
      xuLyRanDom(saveSL);
      return;
    }
  }
}
