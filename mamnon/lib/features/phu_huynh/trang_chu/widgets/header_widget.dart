import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String name;  // Thêm tham số 'name'

  const HeaderWidget({super.key, required this.name});  // Nhận tham số 'name' trong constructor

  @override
  Widget build(BuildContext context) {
    return Text(
      'Xin chào, $name!',  // Hiển thị tên phụ huynh
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
