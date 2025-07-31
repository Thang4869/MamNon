import 'package:flutter/material.dart';

class FunctionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const FunctionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 212, 162),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color.fromARGB(255, 225, 121, 3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: const Color.fromARGB(255, 225, 121, 3)),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
    );
  }
}