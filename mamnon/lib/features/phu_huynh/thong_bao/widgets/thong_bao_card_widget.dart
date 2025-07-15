import 'package:flutter/material.dart';

class ThongBaoCardWidget extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final bool isPinned;

  const ThongBaoCardWidget({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.isPinned,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: isPinned ? 6 : 2,
      color: isPinned ? Colors.orange[50] : Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (isPinned)
              const Icon(Icons.push_pin, color: Colors.orange),
            if (isPinned) const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(content,
                      style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text(date,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
