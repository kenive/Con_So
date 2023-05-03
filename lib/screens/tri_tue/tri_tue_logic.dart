part of 'tri_tue.dart';

class TriTueLogic extends ChangeNotifier {
  late BuildContext context;

  TriTueLogic({required this.context}) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    xuLyCauHoi();
  }

  List cauHoi = [];

  Object? cauHoiId;

  Map<String, dynamic>? dataCauHoi;

  int countCauHoi = 0;

  List tampCauHoi = [];

  int score = 0;

  List<bool> checkDapAn = [];

  bool selected = false;

  int kq = 10;

  String title = '';

  late Timer timer;

  late Timer timerAll;

  int start = 30;

  List<int> clock = [0, 0, 0, 0];

  void startTimerAll() {
    const second = Duration(seconds: 1);
    timerAll = Timer.periodic(
      second,
      (Timer timer) {
        clock[0]++;
        if (clock[0] == 10) {
          clock[0] = 0;
          clock[1]++;

          if (clock[1] == 6) {
            clock[1] = 0;
            clock[2]++;

            if (clock[2] == 10) {
              clock[2] = 0;
              clock[3]++;
            }
          }
        }
        notifyListeners();
      },
    );
  }

  void startTimer() {
    const second = Duration(seconds: 1);
    timer = Timer.periodic(
      second,
      (Timer timer) {
        if (start == 0) {
          timerAll.cancel();
          timer.cancel();
          showThongBao('Bạn đã hết thời gian', score);
        } else {
          start--;
        }
        notifyListeners();
      },
    );
  }

  void xuLyCauHoi() {
    startTimerAll();

    tampCauHoi = DataCauHoi().diaLy..shuffle();

    cauHoi = tampCauHoi.sublist(5, 20);

    countCauHoi = 0;

    score = 0;

    cauHoiId = cauHoi.first;

    dataCauHoi = chuyenDoi(cauHoiId!);

    checkDapAn = List.filled(4, false);

    startTimer();

    notifyListeners();
  }

  void tiepTuc() {
    if (kq == 0) {
      title = 'Bạn đã chọn sai';
      selected = true;
      timer.cancel();
      timerAll.cancel();
      checkDapAn = List.filled(4, false);
      notifyListeners();
      return;
    }
    selected = false;
    checkDapAn = List.filled(4, false);
    ++countCauHoi;
    if (countCauHoi >= cauHoi.length) {
      score += 100;
      timer.cancel();
      timerAll.cancel();
      notifyListeners();
      showThongBao('Chúc mừng bạn đã chiến thắng trò chơi', score);
      return;
    } else {
      start = 30;
      cauHoiId = cauHoi[countCauHoi];
      score += 100;
      dataCauHoi = chuyenDoi(cauHoiId!);
      Helper.showToast('Đáp án chính xác', context);

      notifyListeners();
    }
  }

  void selectedDapAn(int value, int index) {
    checkDapAn[index] = true;
    selected = true;
    kq = value;
    notifyListeners();
  }

  void chonLai() {
    selected = false;
    // start = 30;
    title = '';
    checkDapAn = List.filled(4, false);
    notifyListeners();
  }

  void timeReset() {
    start = 30;
    clock = [0, 0, 0, 0];
    notifyListeners();
  }

  Map<String, dynamic> chuyenDoi(Object value) {
    return jsonDecode(jsonEncode(value));
  }

  void showThongBao(String title, int score) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.colorTextBlack,
                  ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Thời gian đã chơi: ${clock[3]}${clock[2]} : ${clock[1]}${clock[0]}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorTextBlack,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Tổng điểm: $score',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorTextBlack,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                      child: Text(
                        'Chơi lại',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        chonLai();
                        timeReset();
                        xuLyCauHoi();
                      }),
                ),
              ],
            ),
          );
        });
  }
}
