
import 'package:flutter/material.dart';
import 'package:mamnon/features/phu_huynh/support/back_button_circle.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  Widget _buildHelpButton(String question, String answer, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // tạm để trống
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: '$question\n',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: answer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildHelpButton(
                  'Cách đăng nhập vào ứng dụng?',
                  'Nhấn vào "Đăng nhập" và nhập email cùng mật khẩu.',
                  () {},
                ),
                _buildHelpButton(
                  'Làm thế nào để đổi ngôn ngữ?',
                  'Vào mục "Ngôn ngữ" trong cài đặt để chọn ngôn ngữ mong muốn.',
                  () {},
                ),
                _buildHelpButton(
                  'Giải quyết sự cố kỹ thuật?',
                  'Vui lòng báo cáo qua "Báo cáo sự cố" để được hỗ trợ.',
                  () {},
                ),
              ],
            ),
          ),
          // Nút back + Tiêu đề giống format chuẩn
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              children: [
                BackButtonCircle(),
                const SizedBox(width: 45),
                const Text(
                  'Trung tâm trợ giúp',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}