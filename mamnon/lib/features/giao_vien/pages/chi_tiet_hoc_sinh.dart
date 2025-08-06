import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChiTietHocSinh extends StatefulWidget {
  final String ten;
  final bool daDanhDau;
  final String idHs;

  const ChiTietHocSinh({
    super.key,
    required this.ten,
    required this.daDanhDau,
    required this.idHs,
  });

  @override
  State<ChiTietHocSinh> createState() => _ChiTietHocSinhState();
}

class _ChiTietHocSinhState extends State<ChiTietHocSinh> {
  String gioiTinh = '';
  int namSinh = 0;
  String tenPh = '';
  String sdtPh = '';

  @override
  void initState() {
    super.initState();
    _loadChiTiet();
  }

  Future<void> _loadChiTiet() async {
    try {
      // Lấy thông tin học sinh
      final hsResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/hocsinhs'),
      );
      final hsData = json.decode(hsResponse.body);
      final hs = hsData.firstWhere(
        (item) => item['idHs'].toString().trim() == widget.idHs,
        orElse: () => null,
      );
      if (hs == null) return;

      final idPh = hs['idPh'].toString().trim();
      final gt =
          hs['gioiTinh'].toString().toLowerCase() == 'nam' ? 'Nam' : 'Nữ';

      setState(() {
        gioiTinh = gt;
        namSinh = hs['namSinh'];
      });

      // Lấy thông tin phụ huynh
      final phResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/phuhuynhs/'),
      );
      final phData = json.decode(phResponse.body);
      final ph = phData.firstWhere(
        (item) => item['idPh'].toString().trim() == idPh,
        orElse: () => null,
      );

      if (ph != null) {
        setState(() {
          tenPh = ph['hoTen'];
          sdtPh = ph['sdt'];
        });
      }
    } catch (e) {
      print('❌ Lỗi khi load chi tiết học sinh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết học sinh')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên học sinh: ${widget.ten}', style: _style()),
            const SizedBox(height: 8),
            Text('Giới tính: $gioiTinh', style: _style()),
            const SizedBox(height: 8),
            Text('Năm sinh: $namSinh', style: _style()),
            const SizedBox(height: 8),
            Text('Tên phụ huynh: $tenPh', style: _style()),
            const SizedBox(height: 8),
            Text('SĐT phụ huynh: $sdtPh', style: _style()),
          ],
        ),
      ),
    );
  }

  TextStyle _style() => const TextStyle(fontSize: 18);
}
