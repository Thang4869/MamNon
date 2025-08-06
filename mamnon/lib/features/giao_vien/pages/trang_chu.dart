import 'package:flutter/material.dart';
import 'package:mamnon/features/giao_vien/pages/diem_danh.dart';
import 'package:mamnon/features/giao_vien/pages/ho_so_giao_vien.dart';
import 'package:mamnon/features/giao_vien/pages/ngoai_khoa.dart';
import 'package:mamnon/features/giao_vien/widgets/bottom_navigation.dart';

class TrangChu extends StatelessWidget {
  final Map userInfo; 

  const TrangChu({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrangGiaoVien(userInfo: userInfo),
    );
  }
}

class TrangGiaoVien extends StatefulWidget {
  final Map userInfo;
  const TrangGiaoVien({super.key, required this.userInfo});

  @override
  State<TrangGiaoVien> createState() => _TrangGiaoVienState();
}

class _TrangGiaoVienState extends State<TrangGiaoVien> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    final maSt = widget.userInfo['maSt'] ?? '';
    _pages = [
      DiemDanh(maSt: maSt),
      NgoaiKhoa(maSt: maSt),
      HoSoGiaoVienScreen(userInfo: widget.userInfo),
    ];
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(scaffoldBackgroundColor: Colors.transparent),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD0F5DF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationWidgetGiaoVien(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
