import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamnon/features/phu_huynh/trang_chu/widgets/cate_subject_widget.dart';
import 'package:mamnon/features/phu_huynh/trang_chu/widgets/notification_slider_widget.dart';
import '../../thong_bao/pages/thong_bao_screen.dart';
import '../../chatbot/pages/chatbot_screen.dart';
import '../../profile_phu_huynh/pages/ho_so_phu_huynh_screen.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/tim_kiem_widget.dart';
import '../widgets/danh_sach_mon_hoc_widget.dart';

class MainScreen extends StatefulWidget {
  final Map userInfo;  // Nhận tham số userInfo

  const MainScreen({super.key, required this.userInfo});  // Truyền tham số vào constructor

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  // Khởi tạo danh sách các trang, nhưng không sử dụng widget.userInfo ở đây
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    // Khởi tạo _pages sau khi widget đã được khởi tạo
    _pages = [
      TrangChuPhuHuynh(userInfo: widget.userInfo),  // Truyền userInfo đúng cách
      ThongBaoScreen(),
      ChatbotScreen(),
      HoSoPhuHuynhScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('User Info: ${widget.userInfo}');  // In ra userInfo để kiểm tra
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
      ),
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
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _pages,  // Truyền đúng _pages
          ),
          bottomNavigationBar: BottomNavigationWidget(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}



class TrangChuPhuHuynh extends StatefulWidget {
  final Map userInfo;  // Tham số userInfo

  const TrangChuPhuHuynh({super.key, required this.userInfo});  // Nhận tham số vào constructor
  
  @override
  State<TrangChuPhuHuynh> createState() => _TrangChuPhuHuynhState();
}

class _TrangChuPhuHuynhState extends State<TrangChuPhuHuynh> {
  bool _showAllSubjects = false;

  @override
  Widget build(BuildContext context) {
    print('User Info in TrangChuPhuHuynh: ${widget.userInfo}');
    print('Tên phụ huynh: ${widget.userInfo['hoTen']}');
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(name: widget.userInfo['hoTen']?.toString().trim() ?? 'Không có tên'),
              const SizedBox(height: 20),
              const TimKiemWidget(),
              const SizedBox(height: 28),
              const CateSubjectWidget(),
              const SizedBox(height: 28),
              const NotificationSliderWidget(),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Các Môn học phổ biến',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showAllSubjects = !_showAllSubjects;
                      });
                    },
                    child: Text(
                      _showAllSubjects ? 'Thu gọn' : 'Tất cả',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DanhSachMonHocWidget(showAll: _showAllSubjects),
            ],
          ),
        ),
      ),
    );
  }
}
