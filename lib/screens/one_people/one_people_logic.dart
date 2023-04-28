part of 'one_people.dart';

class OnePeopleLogic extends ChangeNotifier {
  late BuildContext context;
  OnePeopleLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String value = ModalRoute.of(context)!.settings.arguments as String;
      xuLyRanDom(int.parse(value));
    });
  }

  int saveSL = 0;

  int kq = 0;

  List<int> test = [];

  List<bool> checkOpen = [];

  final random = Random();

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
