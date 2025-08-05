import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamnon/features/hoc_sinh/models/child.dart';
import 'package:mamnon/features/phu_huynh/settings/language_setting.dart';
import 'package:mamnon/features/phu_huynh/settings/notify_setting.dart';
import 'package:mamnon/features/phu_huynh/settings/pass_security_setting.dart';
import 'package:mamnon/features/phu_huynh/settings/theme_setting.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_form.dart';
import '../widgets/child_card.dart';

class HoSoPhuHuynhScreen extends StatefulWidget {
  const HoSoPhuHuynhScreen({super.key});

  @override
  _HoSoPhuHuynhScreenState createState() => _HoSoPhuHuynhScreenState();
}

class _HoSoPhuHuynhScreenState extends State<HoSoPhuHuynhScreen>
    with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  XFile? _avatarFile;
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final List<Child> _children = [];
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

    final children = await _loadChildrenFromJson();

    setState(() {
      _emailCtrl.text = 'phuhuynh@gmail.com';
      _phoneCtrl.text = '+84 1234 5678';
      _children.addAll(children);
      _loading = false;
    });
  }

  Future<List<Child>> _loadChildrenFromJson() async {
    final jsonString = await rootBundle.loadString('assets/data/child.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Child.fromJson(json)).toList();
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
        child:
            _loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: padH, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      ProfileHeader(
                        avatarFile: _avatarFile,
                        name: 'Nguyễn Văn Thắng',
                        email: _emailCtrl.text,
                        onEdit: _toggleEdit,
                        onAvatarTap: _pickAvatar,
                      ),
                      const SizedBox(height: 15),
                      // Edit form slide
                      SlideTransition(
                        position: _slideAnimation,
                        child:
                            _isEditing
                                ? ProfileForm(
                                  isEditing: _isEditing,
                                  emailController: _emailCtrl,
                                  phoneController: _phoneCtrl,
                                )
                                : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                      // Children grid
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children:
                            _children.map((c) {
                              return SizedBox(
                                width: (width - padH * 2 - 12) / 2,
                                child: ChildCard(
                                  child: c,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/child_detail', // hoặc thay bằng MaterialPageRoute
                                      arguments: c.toJson(),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Settings & Support section with expandable lists
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Column(
                          children: [
                            // Yêu thích - mở form riêng
                            ListTile(
                              leading: const Icon(Icons.favorite),
                              title: const Text('Yêu thích'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.pushNamed(context, '/favorites');
                              },
                            ),
                            const Divider(height: 1),
                            // Trợ giúp & hỗ trợ expandable
                            ExpansionTile(
                              leading: const Icon(Icons.support_agent),
                              title: const Text('Trợ giúp & hỗ trợ'),
                              children: [
                                ListTile(
                                  title: const Text('Trung tâm trợ giúp'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: const Text('Hộp thư hỗ trợ'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: const Text('Báo cáo sự cố'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: const Text('Điều khoản & chính sách'),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            const Divider(height: 1),
                            // Cài đặt expandable
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
                                        builder:
                                            (context) =>
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
                                        builder:
                                            (context) =>
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
                                        builder:
                                            (context) =>
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
                                        builder:
                                            (context) =>
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
                                // TODO: Handle logout
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
