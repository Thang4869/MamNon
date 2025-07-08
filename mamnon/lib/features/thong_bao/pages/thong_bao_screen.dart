import 'package:flutter/material.dart';
import '../models/thong_bao_model.dart';
import '../../thong_bao/widgets/thong_bao_card_widget.dart';

class ThongBaoScreen extends StatelessWidget {
  const ThongBaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ThongBaoModel> thongBaoList = [
      ThongBaoModel(
        title: 'Lễ hội Trung thu',
        content: 'Trường tổ chức lễ hội Trung thu cho các bé vào ngày 20/09.',
        date: '04/09/2025',
        isPinned: true,
      ),
      ThongBaoModel(
        title: 'Họp Phụ huynh đầu năm',
        content: 'Buổi họp diễn ra vào ngày 10/09 tại phòng đa năng.',
        date: '01/09/2025',
        isPinned: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo từ nhà trường'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: thongBaoList.length,
        itemBuilder: (context, index) {
          final tb = thongBaoList[index];
          return ThongBaoCardWidget(
            title: tb.title,
            content: tb.content,
            date: tb.date,
            isPinned: tb.isPinned,
          );
        },
      ),
    );
  }
}
