import 'package:flutter/material.dart';

class DanhSachMonHocWidget extends StatelessWidget {
  const DanhSachMonHocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {'name': 'Toán', 'image': 'https://i.imgur.com/KTC6cUR.png'},
      {'name': 'Âm nhạc', 'image': 'https://i.imgur.com/l49aYSn.png'},
      {'name': 'Mỹ thuật', 'image': 'https://i.imgur.com/T6CtFzR.png'},
      {'name': 'Thể dục', 'image': 'https://i.imgur.com/y3X7XkF.png'},
    ];

    return GridView.builder(
      itemCount: subjects.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  subject['image']!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subject['name']!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
