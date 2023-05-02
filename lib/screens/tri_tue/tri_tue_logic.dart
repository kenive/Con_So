part of 'tri_tue.dart';

class TriTueLogic extends ChangeNotifier {
  late BuildContext context;

  TriTueLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    xuLyCauHoi();
  }

  List cauHoi = [];

  Object? cauHoiId;

  int id = 0;

  Map<String, dynamic>? dataCauHoi;

  void xuLyCauHoi() {
    cauHoi = CauHoi().diaLy..shuffle();

    cauHoiId = cauHoi.first;

    dataCauHoi = chuyenDoi(cauHoiId!);

    id = dataCauHoi!['id'];

    notifyListeners();
  }

  void tiepTuc(int value) {
    cauHoiId = cauHoi.where((element) => element['id'] == value).first;

    dataCauHoi = chuyenDoi(cauHoiId!);

    id = dataCauHoi!['id'];

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
                      }),
                ),
              ],
            ),
          );
        });
  }
}
