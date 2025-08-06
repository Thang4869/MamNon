import 'package:flutter/material.dart';
import 'package:mamnon/features/giao_vien/widgets/ngoai_khoa_card.dart';

class NgoaiKhoa extends StatelessWidget {
  final String maSt;

  const NgoaiKhoa({super.key, required this.maSt});

  @override
  Widget build(BuildContext context) {
    // Sử dụng maSt tại đây
    return Scaffold(
      body: Center(child: Text("Trang ngoại khóa - maSt: $maSt")),
    );
  }
}

class NgoaiKhoaBody extends StatelessWidget {
  const NgoaiKhoaBody({super.key});

  final List<Map<String, dynamic>> activities = const [
    {
      'title': 'Hội thảo Khoa học',
      'start': '15-08-2025',
      'end': '20-08-2025',
      'description': '',
    },
    {
      'title': 'Trại hè Tiếng Anh',
      'start': '15-08-2025',
      'end': '20-08-2025',
      'description': 'Trại hè giúp trẻ cải thiện kỹ năng tiếng Anh',
    },
    {
      'title': 'Cuộc thi Vẽ',
      'start': '15-08-2025',
      'end': '20-08-2025',
      'description': 'Cuộc thi dành cho tất cả học sinh yêu thích vẽ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header màu nền xanh
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

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ActivityCard(
                  title: activity['title'],
                  start: activity['start'],
                  end: activity['end'],
                  description: activity['description'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
