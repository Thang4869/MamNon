import 'package:flutter/material.dart';

class ChiTietMonHocScreen extends StatelessWidget {
  final String tenMon;
  final String moTa;
  final String thoiHan;

  const ChiTietMonHocScreen({
    super.key,
    required this.tenMon,
    required this.moTa,
    required this.thoiHan,
  });

  Icon _getIcon(String mon) {
    switch (mon.toLowerCase()) {
      case 'sức khỏe':
        return const Icon(Icons.health_and_safety,
            color: Colors.redAccent, size: 40);
      case 'tiếng việt':
        return const Icon(Icons.menu_book, color: Colors.green, size: 40);
      case 'âm nhạc':
        return const Icon(Icons.music_note, color: Colors.purple, size: 40);
      case 'mỹ thuật':
        return const Icon(Icons.brush, color: Colors.orange, size: 40);
      default:
        return const Icon(Icons.school, color: Colors.blueGrey, size: 40);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFFF6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    tenMon,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Icon lớn chủ đề
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3))
                ],
              ),
              child: _getIcon(tenMon),
            ),

            const SizedBox(height: 24),

            // Card thông tin
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.push_pin, color: Colors.red),
                        SizedBox(width: 8),
                        Text("Mô tả",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(moTa),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.timer, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("Thời hạn",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(thoiHan),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Số lượng còn
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.track_changes, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Số lượng còn: 20",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                ],
              ),
            ),

            const Spacer(),

            // Nút đăng ký
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đăng ký thành công!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F7B0),
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 6,
                ),
                child: const Text("Đăng Ký",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
