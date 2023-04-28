import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtSL = TextEditingController();

  TextEditingController txtUser1 = TextEditingController();

  TextEditingController txtUser2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Nhập số lượng ô'),
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
                                      child: const Text("Đồng ý"),
                                      onPressed: () {
                                        if (txtSL.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Không được bỏ trống')));
                                          return;
                                        }
                                        FocusScope.of(context).unfocus();
                                        Navigator.of(context).pop();
                                        Navigator.pushNamed(
                                            context, '/one_people',
                                            arguments: txtSL.text);
                                        txtSL.clear();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Text("Đóng"),
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        txtSL.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text('Tìm số')),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          // barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Chọn chế độ'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: txtUser1,
                                    decoration: const InputDecoration(
                                        hintText: 'Nhập tên người chơi 1'),
                                  ),
                                  TextFormField(
                                    controller: txtUser2,
                                    decoration: const InputDecoration(
                                        hintText: 'Nhập tên người chơi 2'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    child: const Text("Ngắn"),
                                    onPressed: () {
                                      if (txtUser1.text.isEmpty ||
                                          txtUser2.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Vui lòng điền đầy đủ họ tên người chơi')));
                                        return;
                                      }
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(
                                          context, '/two_people', arguments: [
                                        1,
                                        txtUser1.text,
                                        txtUser2.text
                                      ]);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Text('Trung Bình'),
                                      onPressed: () {
                                        if (txtUser1.text.isEmpty ||
                                            txtUser2.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Vui lòng điền đầy đủ họ tên người chơi')));
                                          return;
                                        }
                                        Navigator.of(context).pop();

                                        Navigator.pushNamed(
                                            context, '/two_people', arguments: [
                                          2,
                                          txtUser1.text,
                                          txtUser2.text
                                        ]);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Text("Dài"),
                                      onPressed: () {
                                        if (txtUser1.text.isEmpty ||
                                            txtUser2.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Vui lòng điền đầy đủ họ tên người chơi')));
                                          return;
                                        }
                                        Navigator.of(context).pop();

                                        Navigator.pushNamed(
                                            context, '/two_people', arguments: [
                                          3,
                                          txtUser1.text,
                                          txtUser2.text
                                        ]);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: const Text('Tổng điểm')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
