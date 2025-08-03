import 'package:flutter/material.dart';
import 'package:mamnon/features/hoc_sinh/models/child.dart';
import 'package:mamnon/features/hoc_sinh/models/diemdanh.dart';
import 'package:mamnon/features/hoc_sinh/models/hocsinh_lop.dart';

class TienDoHocTapScreen extends StatelessWidget {
  final Child child;
  final List<DiemDanh> diemDanhList;
  final List<HocSinhLop> hocSinhLopList;

  const TienDoHocTapScreen({
    super.key,
    required this.child,
    required this.diemDanhList,
    required this.hocSinhLopList,
  });

  @override
  Widget build(BuildContext context) {
    // Lọc điểm danh của học sinh
    final List<DiemDanh> diemDanhHS =
        diemDanhList.where((dd) => dd.idHS == child.idHS).toList();

    // Số ngày nghỉ
    final int soNgayNghi =
        diemDanhHS.where((dd) => dd.trangThaiNghi == 1).length;

    // Tìm học sinh trong danh sách lớp để lấy điểm chuyên cần ban đầu
    final HocSinhLop hsLop = hocSinhLopList.firstWhere(
    (e) => e.idHS == child.idHS && e.idLop == child.className,
    orElse: () => HocSinhLop(idHS: child.idHS, idLop: child.className, diemChuyenCan: 10),
    );

    // Tính điểm chuyên cần
    double diemChuyenCan = hsLop.diemChuyenCan - (soNgayNghi * 0.5);
    if (diemChuyenCan < 0) diemChuyenCan = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiến độ học tập'),
        backgroundColor: const Color(0xFFD0F5DF),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD0F5DF), Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 64, color: Colors.teal),
                const SizedBox(height: 20),
                Text(
                  'Bé ${child.name}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Số ngày nghỉ: $soNgayNghi',
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                const SizedBox(height: 12),
                Text(
                  'Điểm chuyên cần: ${diemChuyenCan.toStringAsFixed(1)} / 10.0',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
