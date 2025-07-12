import 'package:flutter/material.dart';

class TimKiemWidget extends StatelessWidget {
  const TimKiemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: 'Tìm kiếm môn học hoặc lớp học',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
