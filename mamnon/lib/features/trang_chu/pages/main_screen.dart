import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../thong_bao/pages/thong_bao_screen.dart';
import '../../chatbot/pages/chatbot_screen.dart';
import '../../phu_huynh/pages/ho_so_phu_huynh_screen.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/tim_kiem_widget.dart';
import '../widgets/danh_sach_mon_hoc_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    TrangChuPhuHuynh(),
    ThongBaoScreen(),
    ChatbotScreen(),
    HoSoPhuHuynhScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
      ),
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationWidget(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class TrangChuPhuHuynh extends StatelessWidget {
  const TrangChuPhuHuynh({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderWidget(),
            SizedBox(height: 20),
            TimKiemWidget(),
            SizedBox(height: 28),
            Text(
              'Các Môn học phổ biến',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Expanded(child: DanhSachMonHocWidget()),
          ],
        ),
      ),
    );
  }
}
