import 'package:flutter/material.dart';

class MonHocDetailScreen extends StatelessWidget {
  final String tenMon;
  final String moTa;
  final String thoiHan;
  final int soLuong;
  final IconData icon;

  const MonHocDetailScreen({
    Key? key,
    required this.tenMon,
    required this.moTa,
    required this.thoiHan,
    required this.soLuong,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tenMon),
        backgroundColor: Colors.deepPurple[200],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Icon(icon, size: 80, color: Colors.deepPurple),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 8),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mô tả", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(moTa),
                const SizedBox(height: 16),
                Text("Thời hạn", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(thoiHan),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Số lượng còn: $soLuong"),
                ElevatedButton(
                  onPressed: () {
                    // hành động đăng ký
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Đăng ký"),
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.deepPurple[50],
    );
  }
}
