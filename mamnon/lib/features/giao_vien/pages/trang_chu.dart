import 'package:flutter/material.dart';
import 'package:mamnon/features/giao_vien/pages/diem_danh.dart';
import 'package:mamnon/features/giao_vien/pages/ngoai_khoa.dart';
import 'package:mamnon/features/giao_vien/widgets/bottom_navigation.dart';

class TrangChu extends StatelessWidget {
  final String maSt; // <- lấy từ login

  const TrangChu({super.key, required this.maSt});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrangGiaoVien(maSt: maSt),
    );
  }
}

class TrangGiaoVien extends StatefulWidget {
  final String maSt;

  const TrangGiaoVien({super.key, required this.maSt});

  @override
  State<TrangGiaoVien> createState() => _TrangGiaoVienState();
}

class _TrangGiaoVienState extends State<TrangGiaoVien> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DiemDanh(maSt: widget.maSt),
      NgoaiKhoa(maSt: widget.maSt),
      //HoSo(maSt: widget.maSt),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              Color(0xFFD0F5DF),
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
