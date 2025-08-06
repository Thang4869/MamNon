import 'package:flutter/material.dart';
import 'package:mamnon/features/giao_vien/widgets/ngoai_khoa_card.dart';
import 'chi_tiet_ngoai_khoa.dart'; // Trang chi tiết

import 'dart:convert';
import 'package:http/http.dart' as http;

class NgoaiKhoa extends StatefulWidget {
  final String maSt;

  const NgoaiKhoa({super.key, required this.maSt});

  @override
  State<NgoaiKhoa> createState() => _NgoaiKhoaState();
}

class _NgoaiKhoaState extends State<NgoaiKhoa> {
  List<Map<String, dynamic>> activities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNgoaiKhoaData();
  }

  Future<void> loadNgoaiKhoaData() async {
    try {
      // 1. Lấy danh sách idNk từ ngoaikhoagiaoviens
      final gvResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/ngoaikhoagiaoviens'),
      );
      final List<dynamic> gvList = jsonDecode(gvResponse.body);
      final idNkList =
          gvList
              .where(
                (item) =>
                    item is Map &&
                    item['maSt'] != null &&
                    item['maSt'].toString().trim() == widget.maSt.trim(),
              )
              .map<String>((item) => item['idNk'].toString().trim())
              .toList();

      // 2. Lấy thông tin từ ngoaikhoas
      final nkResponse = await http.get(
        Uri.parse('http://10.0.2.2:5005/api/ngoaikhoas'),
      );
      final List<dynamic> nkList = jsonDecode(nkResponse.body);

      final filteredActivities =
          nkList
              .where(
                (item) =>
                    item is Map &&
                    item['idNk'] != null &&
                    idNkList.contains(item['idNk'].toString().trim()),
              )
              .map<Map<String, dynamic>>(
                (item) => {
                  'idNk': item['idNk'].toString().trim(),
                  'tenNk': item['tenNk'],
                  'ngayBatDau': item['ngayBatDau'],
                  'ngayKetThu': item['ngayKetThu'],
                  'moTa': item['moTa'],
                },
              )
              .toList();

      setState(() {
        activities = filteredActivities;
        isLoading = false;
      });
    } catch (e) {
      print('❌ Lỗi khi load ngoại khóa: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Column(
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Ngoại khóa',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Danh sách hoạt động
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          final activity = activities[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ChiTietNgoaiKhoa(
                                        tenNk: activity['tenNk'],
                                        ngayBatDau: activity['ngayBatDau'],
                                        ngayKetThu: activity['ngayKetThu'],
                                        moTa: activity['moTa'],
                                      ),
                                ),
                              );
                            },
                            child: ActivityCard(
                              title: activity['tenNk'],
                              start:
                                  activity['ngayBatDau'].toString().split(
                                    'T',
                                  )[0], // chỉ lấy yyyy-MM-dd
                              end:
                                  activity['ngayKetThu'].toString().split(
                                    'T',
                                  )[0],
                              description: '', // không cần ở màn này
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
