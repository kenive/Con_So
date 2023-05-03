part of 'login.dart';

class LoginLogic with ChangeNotifier {
  BuildContext context;
  LoginLogic({required this.context}) {
    if (kDebugMode) {
      txtEmail.text = 'xnguyen759@gmail.com';
      txtMatKhau.text = '123456a';
    }
  }

  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtMatKhau = TextEditingController();

  TextEditingController txtEmailDangKy = TextEditingController();

  TextEditingController txtMatKhauDangKy = TextEditingController();

  TextEditingController txtName = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  DateTime date = DateTime.now();

  bool checkShowPass = true;

  Future<void> login() async {
    try {
      FocusScope.of(context).unfocus();

      Loading.show();
      await auth
          .signInWithEmailAndPassword(
              email: txtEmail.text, password: txtMatKhau.text)
          .then((value) async {
        GetIt.instance<AppVM>().loginSuccess(value.user!.uid);
        Loading.hide();
      });
    } on FirebaseAuthException catch (e) {
      Loading.hide();
      Helper.showToast('Đăng nhập thất bại', context);
      debugPrint('$e');
    }
  }

  Future<void> dangKy() async {
    try {
      if (txtEmailDangKy.text.isEmpty ||
          txtMatKhauDangKy.text.isEmpty ||
          txtName.text.isEmpty) {
        FocusScope.of(context).unfocus();
        Helper.showToast('Không được bỏ trống', context);
        return;
      }
      FocusScope.of(context).unfocus();

      Loading.show();
      await auth
          .createUserWithEmailAndPassword(
              email: txtEmailDangKy.text, password: txtMatKhauDangKy.text)
          .then((value) async {
        if (value.user!.uid.isNotEmpty) {
          String dateFormat = DateFormat('dd-MM-yyyy hh:mm:ss').format(date);

          DatabaseService(uid: value.user!.uid)
              .savingUserData(value.user!.email!, txtName.text, dateFormat);

          clearDangKy();

          Loading.hide();

          Helper.showToast('Đăng ký thành công', context);

          NavigationService.gotoAuth();
        }
      });
    } on FirebaseAuthException catch (e) {
      FocusScope.of(context).unfocus();
      Loading.hide();
      if (e.code.contains('invalid-email')) {
        Helper.showToast('Email không đúng đinh dạng', context);
      } else if (e.code.contains('email-already-in-use')) {
        Helper.showToast('Email này đã được đăng ký', context);
      }

      debugPrint('$e');
    }
  }

  void clearDangKy() {
    txtEmailDangKy.clear();
    txtMatKhauDangKy.clear();
    txtName.clear();
    notifyListeners();
  }

  void showPass() {
    checkShowPass = !checkShowPass;
    notifyListeners();
  }
}
