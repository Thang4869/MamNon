import 'package:flutter/material.dart';
import 'package:mamnon/features/hoc_sinh/page/ho_so_hoc_sinh_screen.dart';
import 'package:mamnon/features/phu_huynh/support/help_center_screen.dart';
import 'package:mamnon/features/phu_huynh/support/terms_policy_screen.dart';
import 'package:mamnon/login/welcome_screen.dart';

class QuanLyDuongDan {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const WelcomeScreen(),
    '/child_detail': (context) => const HoSoHocSinhScreen(),
    '/help_center': (context) => const HelpCenterScreen(),
    '/terms_policy': (context) => const TermsPolicyScreen(),
  };
}
