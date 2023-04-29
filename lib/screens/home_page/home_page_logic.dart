part of 'home_page.dart';

class HomePageLogic with ChangeNotifier {
  BuildContext context;
  HomePageLogic({required this.context});
  TextEditingController txtSL = TextEditingController();

  TextEditingController txtUser1 = TextEditingController();

  TextEditingController txtUser2 = TextEditingController();

  List item = ['Tìm số', 'Tổng điểm'];

  void choDo(int value) {
    if (txtUser1.text.isEmpty || txtUser2.text.isEmpty) {
      Helper.showSnackBar('Vui lòng điền đẩy đủ họ tên', context);
      return;
    }

    Navigator.pushNamed(context, AppRoutes.tongDiem,
        arguments: [value, txtUser1.text, txtUser2.text]).then((value) {
      Navigator.of(context).pop();
    });
  }

  void tongDiem() {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            title: Text(
              'Chọn chế độ',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorTextBlack,
                  ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: txtUser1,
                  decoration:
                      const InputDecoration(hintText: 'Nhập tên người chơi 1'),
                ),
                TextFormField(
                  controller: txtUser2,
                  decoration:
                      const InputDecoration(hintText: 'Nhập tên người chơi 2'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text(
                    'Ngắn',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorTextBlack,
                        ),
                  ),
                  onPressed: () {
                    print('object');
                    choDo(1);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      'Trung Bình',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    onPressed: () {
                      choDo(2);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      'Dài',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    onPressed: () {
                      choDo(3);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
