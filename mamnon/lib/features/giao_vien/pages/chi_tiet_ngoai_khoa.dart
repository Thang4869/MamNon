import 'package:flutter/material.dart';

class ChiTietNgoaiKhoa extends StatelessWidget {
  final String tenNk;
  final String ngayBatDau;
  final String ngayKetThu;
  final String moTa;

  const ChiTietNgoaiKhoa({
    super.key,
    required this.tenNk,
    required this.ngayBatDau,
    required this.ngayKetThu,
    required this.moTa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tenNk)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tên ngoại khóa: $tenNk',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Ngày bắt đầu: ${ngayBatDau.split("T")[0]}'),
            const SizedBox(height: 8),
            Text('Ngày kết thúc: ${ngayKetThu.split("T")[0]}'),
            const SizedBox(height: 8),
            Text('Mô tả: $moTa'),
          ],
        ),
      ),
    );
  }
}
