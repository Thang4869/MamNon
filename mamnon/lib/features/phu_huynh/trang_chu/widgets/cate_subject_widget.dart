import 'package:flutter/material.dart';

class CateSubjectWidget extends StatelessWidget {
  const CateSubjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['Tiếng Việt', 'Âm nhạc', 'Mỹ thuật', 'Thể dục'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Cho phép cuộn ngang
        child: Row(
          children: categories.map((name) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ElevatedButton(
                onPressed: () {
                  // event ontap category Subjects
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(color: Colors.black12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
