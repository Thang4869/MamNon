import 'package:flutter/material.dart';
import 'package:mamnon/features/hoc_sinh/models/child.dart';
import 'package:mamnon/features/hoc_sinh/models/diemdanh.dart';

class SoBuoiVangScreen extends StatelessWidget {
  final Child child;
  final List<DiemDanh> allDiemDanh;

  const SoBuoiVangScreen({
    super.key,
    required this.child,
    required this.allDiemDanh,
  });

  @override
  Widget build(BuildContext context) {
    final List<DiemDanh> diemDanhHS =
        allDiemDanh.where((dd) => dd.idHS == child.idHS).toList();

    final int tongSoNgayDiemDanh = diemDanhHS.length;
    final int soNgayNghi =
        diemDanhHS.where((dd) => dd.trangThaiNghi == 1).length;
    final int soBuoiDiHoc = tongSoNgayDiemDanh - soNgayNghi;

    final List<String> ngayNghiList = diemDanhHS
        .where((dd) => dd.trangThaiNghi == 1)
        .map((dd) => '${dd.ngay.day}/${dd.ngay.month}/${dd.ngay.year}')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin ngày vắng học',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFD0F5DF),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD0F5DF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: soNgayNghi > 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: Colors.redAccent, size: 50),
                        const SizedBox(height: 12),
                        Text(
                          'Bé ${child.name} đã nghỉ học $soNgayNghi ngày.',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Danh sách ngày nghỉ:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ngayNghiList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: ListTile(
                                leading: const Icon(Icons.calendar_today,
                                    color: Colors.deepOrange),
                                title: Text(
                                  ngayNghiList[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.celebration,
                          color: Colors.green, size: 50),
                      SizedBox(height: 12),
                      Text(
                        'Bé đi học đầy đủ!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
