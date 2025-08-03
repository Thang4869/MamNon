import 'package:flutter/material.dart';
import '../models/thong_bao_model.dart';
import '../widgets/thong_bao_card_widget.dart';

class ThongBaoScreen extends StatefulWidget {
  const ThongBaoScreen({super.key});

  @override
  State<ThongBaoScreen> createState() => _ThongBaoScreenState();
}

class _ThongBaoScreenState extends State<ThongBaoScreen> {
  String _layGioHienTai() {
    final now = DateTime.now();
    final gio = now.hour;
    final phut = now.minute.toString().padLeft(2, '0');
    final buoi = gio >= 12 ? 'PM' : 'AM';
    final gio12 = gio % 12 == 0 ? 12 : gio % 12;
    return '$gio12:$phut $buoi';
  }

  late List<ThongBaoModel> dsThongBao;

  @override
  void initState() {
    super.initState();

    dsThongBao = [
      ThongBaoModel(
        title: "Thông báo 1",
        content: "Nội dung TB 1",
        date: _layGioHienTai(),
        isPinned: false,
      ),
      ThongBaoModel(
        title: "Thông báo 2",
        content: "Nội dung TB 2",
        date: _layGioHienTai(),
        isPinned: true,
      ),
      ThongBaoModel(
        title: "Thông báo 3",
        content: "Nội dung TB 3",
        date: _layGioHienTai(),
        isPinned: false,
      ),
      ThongBaoModel(
        title: "Thông báo 4",
        content: "Nội dung TB 4",
        date: _layGioHienTai(),
        isPinned: false,
      ),
    ];
  }

  void _moChiTiet(ThongBaoModel tb) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tb.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(tb.content, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 12),
                Text(tb.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );

    setState(() {
      tb.isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("THÔNG BÁO"),
        centerTitle: true,
        backgroundColor: const Color(0xFFD0F5DF),
      ),
      body: ListView.builder(
        itemCount: dsThongBao.length,
        itemBuilder: (context, index) {
          final tb = dsThongBao[index];
          return ThongBaoCardWidget(
            thongBao: tb,
            onTap: () => _moChiTiet(tb),
          );
        },
      ),
    );
  }
}
