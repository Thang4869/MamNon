import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String start;
  final String end;
  final String description;

  const ActivityCard({
    super.key,
    required this.title,
    required this.start,
    required this.end,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          if (description.isNotEmpty)
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          if (description.isNotEmpty) const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('S: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(start),
              const SizedBox(width: 16),
              const Text('E: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(end),
            ],
          ),
        ],
      ),
    );
  }
}
