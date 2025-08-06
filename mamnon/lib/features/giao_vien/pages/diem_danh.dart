import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mamnon/features/giao_vien/pages/chi_tiet_hoc_sinh.dart';

class DiemDanh extends StatefulWidget {
  final String maSt; // lấy từ TrangChu

  const DiemDanh({super.key, required this.maSt});

  @override
  State<DiemDanh> createState() => _DiemDanhState();
}

class _DiemDanhState extends State<DiemDanh> {
  List<String> hocSinh = [];
  List<bool> danhDau = [];
  String tenLop = '';
  String? idLop;
  List<String> idHsList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // 1. Lấy danh sách lớp
      final lopResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/lops/'),
      );
      if (lopResponse.statusCode != 200) throw Exception('Lỗi API lops');
      final lopData = json.decode(lopResponse.body);
      final matchedLop = lopData.firstWhere(
        (lop) => lop['maSt'].toString().trim() == widget.maSt.trim(),
        orElse: () => null,
      );

      if (matchedLop == null) return;

      final lopId = matchedLop['idLop'].toString().trim();
      setState(() {
        tenLop = matchedLop['tenLop'].toString();
        idLop = lopId;
      });

      // 2. Lấy danh sách idHs từ hocsinhlops
      final hsLopResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/hocsinhlops'),
      );
      if (hsLopResponse.statusCode != 200) {
        throw Exception('Lỗi API hocsinhlops');
      }
      final hsLopData = json.decode(hsLopResponse.body);
      idHsList =
          hsLopData
              .where(
                (item) =>
                    item['idLop'] != null &&
                    item['idLop'].toString().trim() == lopId,
              )
              .map<String>((item) => item['idHs'].toString().trim())
              .toList();
      print('✅ idHsList: $idHsList');

      // 3. Lấy thông tin học sinh
      final hsResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/hocsinhs'),
      );
      if (hsResponse.statusCode != 200) throw Exception('Lỗi API hocsinhs');
      final hsData = json.decode(hsResponse.body);

      final tenHsList =
          hsData
              .where(
                (hs) =>
                    hs['idHs'] != null &&
                    idHsList.contains(hs['idHs'].toString().trim()),
              )
              .map<String>((hs) => hs['tenHs'].toString())
              .toList();

      print('✅ tenHsList: $tenHsList');

      setState(() {
        hocSinh = tenHsList;
        danhDau = List.filled(hocSinh.length, false);
      });
    } catch (e) {
      print('❌ Lỗi khi load dữ liệu: $e');
    }
  }

  void _moChiTiet(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ChiTietHocSinh(
              ten: hocSinh[index],
              daDanhDau: danhDau[index],
              idHs: idHsList[index],
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Center(
              child: Text(
                tenLop.isNotEmpty ? tenLop : 'Đang tải lớp...',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Banner hình ảnh + ngày
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/giaovien/diem_danh.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: Text(
                      'Hôm nay là ngày: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Column(
              children: List.generate(hocSinh.length, (index) {
                return GestureDetector(
                  onTap: () => _moChiTiet(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            hocSinh[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: danhDau[index],
                          onChanged: (bool? value) {
                            setState(() {
                              danhDau[index] = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
