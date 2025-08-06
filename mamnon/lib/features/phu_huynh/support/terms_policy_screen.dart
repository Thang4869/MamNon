import 'package:flutter/material.dart';

import 'package:mamnon/features/phu_huynh/support/back_button_circle.dart';
class TermsPolicyScreen extends StatelessWidget {
  const TermsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: BackButtonCircle(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Điều khoản và chính sách',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1. Người dùng phải tuân thủ các quy định của ứng dụng.'),
              SizedBox(height: 8),
              Text('2. Dữ liệu cá nhân sẽ được bảo mật theo chính sách bảo mật.'),
              SizedBox(height: 8),
              Text(
                  '3. Ứng dụng không chịu trách nhiệm cho các thông tin sai lệch từ người dùng.'),
            ],
          ),
        ),
      ),
    );
  }
}
