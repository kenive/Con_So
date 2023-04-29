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

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Đăng nhập thất bại',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
      )));
      debugPrint('$e');
    }
  }

  Future<void> dangKy() async {
    try {
      FocusScope.of(context).unfocus();
      Loading.show();
      await auth
          .createUserWithEmailAndPassword(
              email: txtEmailDangKy.text, password: txtMatKhauDangKy.text)
          .then((value) async {
        if (value.user!.uid.isNotEmpty) {
          DatabaseService(uid: value.user!.uid)
              .savingUserData(value.user!.email!);
          clearDangKy();
          Loading.hide();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            'Đăng ký thành công',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
          )));
          NavigationService.gotoAuth();
        }
      });
    } on FirebaseAuthException catch (e) {
      FocusScope.of(context).unfocus();
      Loading.hide();
      if (e.code.contains('invalid-email')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Email không đúng định dạng',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
        )));
      } else if (e.code.contains('email-already-in-use')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Email đã được đăng ký',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
        )));
      }

      debugPrint('$e');
    }
  }

  void clearDangKy() {
    txtEmailDangKy.clear();
    txtMatKhauDangKy.clear();
    notifyListeners();
  }
}
