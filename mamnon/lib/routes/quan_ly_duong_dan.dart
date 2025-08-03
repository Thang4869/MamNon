import 'package:flutter/material.dart';
import 'package:mamnon/features/hoc_sinh/page/ho_so_hoc_sinh_screen.dart';
import '../features/phu_huynh/trang_chu/pages/main_screen.dart';
class QuanLyDuongDan {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const MainScreen(),
    '/child_detail': (context) => const HoSoHocSinhScreen(),
  };
}

