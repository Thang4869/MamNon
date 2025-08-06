import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThongBaoCardWidget extends StatelessWidget {
  final String title;
  final String noiDung;
  final DateTime ngayTao;
  final bool isRead;

  const ThongBaoCardWidget({
    super.key,
    required this.title,
    required this.noiDung,
    required this.ngayTao,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy – HH:mm').format(ngayTao);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: isRead ? 1 : 4,
      color: isRead ? Colors.white : const Color(0xFFFFF4E5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications_none, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              noiDung,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                dateFormatted,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
