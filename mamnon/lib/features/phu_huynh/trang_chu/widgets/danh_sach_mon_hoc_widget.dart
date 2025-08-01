import 'package:flutter/material.dart';

class DanhSachMonHocWidget extends StatelessWidget {
  const DanhSachMonHocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {'name': 'Tiếng việt', 'image': 'icons/TiengViet.png','type': 'asset'},
      {'name': 'Âm nhạc', 'image': 'icons/AmNhac.png','type': 'asset'},
      {'name': 'Sức khỏe', 'image': 'icons/SucKhoe.png','type': 'asset'},
      {'name': 'Hình Học', 'image': 'icons/HinhHoc.png','type': 'asset'},
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: subjects.length,
        padding: const EdgeInsets.only(right: 16),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              width: 230,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  //event ontap category Subjects
                  print('Tapped on ${subject['name']}');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          color: const Color.fromARGB(133, 251, 231, 210),
                          child: subject['type'] == 'network'
                              ? Image.network(
                                  subject['image']!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                )
                              : Image.asset(
                                  subject['image']!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          subject['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}