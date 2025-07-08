import 'package:flutter/material.dart';
import '../features/trang_chu/pages/main_screen.dart';
class QuanLyDuongDan {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const MainScreen(),
  };
}

