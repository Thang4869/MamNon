import 'package:flutter/material.dart';
import '../../trang_chu/pages/chi_tiet_mon_hoc_screen.dart';

class DanhSachMonHocWidget extends StatelessWidget {
  final bool showAll;
  const DanhSachMonHocWidget({super.key, this.showAll = false});

  @override
  Widget build(BuildContext context) {
    final subjects = [
  {
    'name': 'Tiếng Việt',
    'image': 'icons/TiengViet.png',
    'type': 'asset',
    'moTa': 'Phát triển kỹ năng đọc viết và từ vựng',
    'thoiHan': '3 tháng',
    'soLuongCon': '20',
    'donGia': '300000',
  },
  {
    'name': 'Âm Nhạc',
    'image': 'icons/AmNhac.png',
    'type': 'asset',
    'moTa': 'Khơi dậy cảm xúc và khả năng cảm thụ âm nhạc',
    'thoiHan': '2 tháng',
    'soLuongCon': '15',
    'donGia': '250000',
  },
  {
    'name': 'Sức Khỏe',
    'image': 'icons/SucKhoe.png',
    'type': 'asset',
    'moTa': 'Giáo dục về thể chất và sức khỏe học đường',
    'thoiHan': '1.5 tháng',
    'soLuongCon': '10',
    'donGia': '200000',
  },
  {
    'name': 'Hình Học',
    'image': 'icons/HinhHoc.png',
    'type': 'asset',
    'moTa': 'Nhận biết hình dạng và phát triển tư duy không gian',
    'thoiHan': '2 tháng',
    'soLuongCon': '18',
    'donGia': '280000',
  },
];

    final displaySubjects = showAll ? subjects : subjects.take(2).toList();

    void _navigateToDetail(BuildContext context, Map<String, String> subject) {
      Navigator.push(
        context,
        MaterialPageRoute(
         builder: (context) => ChiTietMonHocScreen(
          tenMon: subject['name']!,
          moTa: subject['moTa']!,
          thoiHan: subject['thoiHan']!,
          soLuongCon: int.parse(subject['soLuongCon']!),
  donGia: int.parse(subject['donGia']!),
),

        ),
      );
    }

    if (showAll) {
      return Column(
        children: displaySubjects.map((subject) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _navigateToDetail(context, subject),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          color: const Color.fromARGB(133, 251, 231, 210),
                          child: subject['type'] == 'network'
                              ? Image.network(subject['image']!, fit: BoxFit.contain)
                              : Image.asset(subject['image']!, fit: BoxFit.contain),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
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
        }).toList(),
      );
    } else {
      return SizedBox(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: displaySubjects.length,
          padding: const EdgeInsets.only(right: 16),
          itemBuilder: (context, index) {
            final subject = displaySubjects[index];
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                width: 230,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _navigateToDetail(context, subject),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            color: const Color.fromARGB(133, 251, 231, 210),
                            child: subject['type'] == 'network'
                                ? Image.network(subject['image']!, fit: BoxFit.contain)
                                : Image.asset(subject['image']!, fit: BoxFit.contain),
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
}
