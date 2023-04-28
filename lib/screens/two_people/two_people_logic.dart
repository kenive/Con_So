part of 'two_people.dart';

class TwoPeoPleLogic extends ChangeNotifier {
  late BuildContext context;

  TwoPeoPleLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List value = ModalRoute.of(context)!.settings.arguments as List;
      nameUser1 = value[1];
      nameUser2 = value[2];
      doKho = value[0];
      xuLyCheDo(value[0]);
    });
  }
  int doKho = 0;

  String nameUser1 = '';

  String nameUser2 = '';

  List<int> lstRandom = [];

  List<bool> checkOpen = [];

  List<bool> user = [false, false];

  List<int> user1 = [];

  List<int> user2 = [];

  int sttUser = 0;

  int scoreUser1 = 0;

  int scoreUser2 = 0;

  final random = Random();

  void xuLyCheDo(int cheDo) {
    if (cheDo == 1) {
      lstRandom = List.generate(20, (index) => random.nextInt(100));
      checkOpen = List.filled(20, false);
      notifyListeners();
      return;
    }
    if (cheDo == 2) {
      lstRandom = List.generate(50, (index) => random.nextInt(150));
      checkOpen = List.filled(50, false);
      notifyListeners();
      return;
    }
    lstRandom = List.generate(100, (index) => random.nextInt(200));
    checkOpen = List.filled(100, false);
    notifyListeners();
  }

  void selected(int index) {
    if (checkOpen[index]) {
      return;
    }

    if (sttUser == 0) {
      checkOpen[index] = true;
      user[0] = !user[0];
      user[1] = false;
      user1.add(index);
      scoreUser1 += lstRandom[index];
      sttUser = 1;
    } else {
      checkOpen[index] = true;
      user[1] = !user[1];
      user[0] = false;
      user2.add(index);
      scoreUser2 += lstRandom[index];
      sttUser = 0;
    }

    if (user2.length == lstRandom.length / 2) {
      if (scoreUser1 > scoreUser2) {
        showThongBao(nameUser1, scoreUser1);
      } else {
        showThongBao(nameUser2, scoreUser2);
      }
    }

    // mayTinhAI();
    notifyListeners();
  }

  void mayTinhAI() {
    int indexUser2 = randomAI();
    if (ktSelect(indexUser2)) {
      checkOpen[indexUser2] = true;
      user[1] = !user[1];
      user[0] = false;
      user2.add(indexUser2);
      scoreUser2 += lstRandom[indexUser2];
      sttUser = 0;
      notifyListeners();
      return;
    }
    mayTinhAI();
  }

  int randomAI() {
    return random.nextInt(doKho == 1
        ? 20
        : doKho == 2
            ? 50
            : 100);
  }

  bool ktSelect(int index) {
    if (user1.contains(index)) {
      return false;
    }
    return true;
  }

  void resetGame() {
    user1 = [];

    user2 = [];

    sttUser = 0;

    scoreUser1 = 0;

    scoreUser2 = 0;

    notifyListeners();
  }

  void showThongBao(String title, int score) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("$title Thắng"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Tổng điểm: $score'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: const Text("Chơi lại"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        resetGame();
                        xuLyCheDo(doKho);
                      }),
                ),
              ],
            ),
          );
        });
  }
}
