import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamnon/features/giao_vien/pages/chi_tiet_ho_so_giao_vien.dart';
import 'package:mamnon/features/phu_huynh/profile_phu_huynh/widgets/profile_form.dart';
import 'package:mamnon/features/phu_huynh/profile_phu_huynh/widgets/profile_header.dart';
import 'package:mamnon/features/phu_huynh/settings/language_setting.dart';
import 'package:mamnon/features/phu_huynh/settings/notify_setting.dart';
import 'package:mamnon/features/phu_huynh/settings/pass_security_setting.dart';
import 'package:mamnon/features/phu_huynh/settings/theme_setting.dart';
import 'package:mamnon/features/phu_huynh/support/report_issue_screen.dart';
import 'package:mamnon/features/phu_huynh/support/support_mailbox_screen.dart';
import 'package:mamnon/login/login_screen.dart';

class HoSoGiaoVienScreen extends StatefulWidget {
  final Map userInfo;

  const HoSoGiaoVienScreen({super.key, required this.userInfo});

  @override
  State<HoSoGiaoVienScreen> createState() => _HoSoGiaoVienScreenState();
}

class _HoSoGiaoVienScreenState extends State<HoSoGiaoVienScreen>
    with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  XFile? _avatarFile;
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _loading = true;

  late final AnimationController _animController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _loadProfile();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _emailCtrl.text = widget.userInfo['email']?.toString().trim() ?? '';
      _phoneCtrl.text = widget.userInfo['sdt']?.toString().trim() ?? '';
      _loading = false;
    });
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarFile = pickedFile;
      });
    }
  }

  void _toggleEdit() {
    setState(() => _isEditing = !_isEditing);
    if (_isEditing) {
      _animController.forward();
    } else {
      _animController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padH = width * 0.06;

    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: padH, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    ProfileHeader(
                      avatarFile: _avatarFile,
                      name: widget.userInfo['hoTen'] ?? '',
                      email: _emailCtrl.text,
                      onEdit: _toggleEdit,
                      onAvatarTap: _pickAvatar,
                    ),
                    const SizedBox(height: 15),
                    // Edit form slide
                    SlideTransition(
                      position: _slideAnimation,
                      child: _isEditing
                          ? ProfileForm(
                              isEditing: _isEditing,
                              emailController: _emailCtrl,
                              phoneController: _phoneCtrl,
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 20),

                    // Settings & Support section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.info),
                            title: const Text('Xem chi tiết hồ sơ'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChiTietHoSoGiaoVienScreen(userInfo: widget.userInfo),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          // Trợ giúp & hỗ trợ
                          ExpansionTile(
                            leading: const Icon(Icons.support_agent),
                            title: const Text('Trợ giúp & hỗ trợ'),
                            children: [
                              ListTile(
                                title: const Text('Trung tâm trợ giúp'),
                                onTap: () {
                                  Navigator.pushNamed(context, '/help_center');
                                },
                              ),
                              ListTile(
                                title: const Text('Hộp thư hỗ trợ'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SupportMailboxScreen(
                                        idPH: widget.userInfo['maSt'] ?? '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: const Text('Báo cáo sự cố'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ReportIssueScreen(
                                        idPH: widget.userInfo['maSt'] ?? '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: const Text('Điều khoản & chính sách'),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/terms_policy',
                                  );
                                },
                              ),
                            ],
                          ),
                          const Divider(height: 1),

                          // Cài đặt
                          ExpansionTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('Cài đặt'),
                            children: [
                              ListTile(
                                title: const Text('Mật khẩu và bảo mật'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PassSecuritySettingScreen(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: const Text('Thông báo'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationSettingsScreen(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: const Text('Ngôn ngữ'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LanguageSettingScreen(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: const Text('Giao diện'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ThemeSettingScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const Divider(height: 1),

                          // Đăng xuất
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: const Text(
                              'Đăng xuất',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Xác nhận'),
                                  content: const Text(
                                    'Bạn có chắc chắn muốn đăng xuất?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Huỷ'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: const Text(
                                        'Đăng xuất',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

