import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/thong_bao_model.dart';
import 'thong_bao_detail_screen.dart';
import '../widgets/thong_bao_card_widget.dart'; // CHỖ NÀY: Import lại widget giao diện cũ

class ThongBaoScreen extends StatefulWidget {
  final String idPh;

  const ThongBaoScreen({super.key, required this.idPh});

  @override
  State<ThongBaoScreen> createState() => _ThongBaoScreenState();
}

class _ThongBaoScreenState extends State<ThongBaoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<ThongBaoModel> dsThongBao = [];

  @override
  void initState() {
    super.initState();
    fetchThongBao(widget.idPh);
  }

  Future<void> fetchThongBao(String idPh) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5005/api/thongbaophuhuynh/ByPhuHuynh/$idPh'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (!mounted) return;
      setState(() {
        dsThongBao = data.map((e) => ThongBaoModel.fromJson(e)).toList();
      });
    } else {
      print("Lỗi khi tải thông báo");
    }
  }

  Future<void> markAsRead(int idTitle, String idPh) async {
    final url = Uri.parse(
      'http://10.0.2.2:5005/api/thongbaophuhuynh/mark-read?idTitle=$idTitle&idPH=$idPh',
    );
    final response = await http.put(url);

    if (response.statusCode == 204) {
      print("Đã cập nhật trạng thái isRead = true");
    } else {
      print("Cập nhật thất bại");
    }
  }

  void _moChiTiet(ThongBaoModel tb) async {
    if (!tb.isRead) {
      await markAsRead(tb.idTitle, widget.idPh);
      if (!mounted) return;
      setState(() {
        tb.isRead = true;
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ThongBaoDetailScreen(thongBao: tb)),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFD0F5DF),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Thông báo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dsThongBao.length,
                  itemBuilder: (context, index) {
                    final tb = dsThongBao[index];

                    return GestureDetector(
                      onTap: () => _moChiTiet(tb),
                      child: ThongBaoCardWidget(
                        title: tb.title ?? '',
                        noiDung: tb.noiDung ?? '',
                        ngayTao: tb.ngayTao,
                        isRead: tb.isRead,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
