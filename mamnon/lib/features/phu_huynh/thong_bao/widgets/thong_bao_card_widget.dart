import 'package:flutter/material.dart';
import '../models/thong_bao_model.dart';

class ThongBaoCardWidget extends StatelessWidget {
  final ThongBaoModel thongBao;
  final VoidCallback onTap;

  const ThongBaoCardWidget({super.key, required this.thongBao, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: thongBao.isRead ? Colors.white : const Color(0xFFF0FFF5),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                Icon(_getIcon(thongBao), size: 28, color: Colors.black),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(thongBao.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Nội dung thông báo', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Text(thongBao.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          if (!thongBao.isRead)
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            )
        ],
      ),
    );
  }

  IconData _getIcon(ThongBaoModel tb) {
    if (tb.isPinned) return Icons.check_circle_outline;
    return Icons.notifications_none;
  }
}
