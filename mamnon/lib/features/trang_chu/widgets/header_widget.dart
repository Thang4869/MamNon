import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Xin chào, Phụ huynh!',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
