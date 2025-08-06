import 'package:flutter/material.dart';
import '../models/thong_bao_model.dart';

class ThongBaoDetailScreen extends StatelessWidget {
  final ThongBaoModel thongBao;

  const ThongBaoDetailScreen({super.key, required this.thongBao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết thông báo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              thongBao.title ?? "Không có tiêu đề",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Ngày: ${thongBao.ngayTao.toLocal()}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              thongBao.noiDung ?? "Không có nội dung",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
