import 'package:flutter/material.dart';

class MonHocDetailScreen extends StatelessWidget {
  final Map<String, dynamic> monHoc;

  const MonHocDetailScreen({Key? key, required this.monHoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Nút quay lại và tiêu đề
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  BackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        monHoc['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48), // để cân đối với BackButton
                ],
              ),
            ),

            // Hình ảnh và mô tả
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Image.asset(monHoc['image'], height: 100),

                  const SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mô tả", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(monHoc['moTa']),
                        SizedBox(height: 10),
                        Text("Thời hạn", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(monHoc['thoiHan']),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Số lượng + Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Số lượng còn: ${monHoc['soLuong']}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {},
                    child: Text("Đăng Ký", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            // Đơn giá
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Đơn giá: ${monHoc['donGia']}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
