part of 'home_page.dart';

class HomePageLogic with ChangeNotifier {
  BuildContext context;
  HomePageLogic({required this.context});
  TextEditingController txtSL = TextEditingController();

  TextEditingController txtUser1 = TextEditingController();

  TextEditingController txtUser2 = TextEditingController();

  List item = ['Tìm số', 'Trí tuệ'];

  // void choDo(int value) {
  //   if (txtUser1.text.isEmpty || txtUser2.text.isEmpty) {
  //     Helper.showSnackBar('Vui lòng điền đẩy đủ họ tên', context);
  //     return;
  //   }

  //   Navigator.pushNamed(context, AppRoutes.tongDiem,
  //       arguments: [value, txtUser1.text, txtUser2.text]).then((value) {
  //     Navigator.of(context).pop();
  //   });
  // }
}
