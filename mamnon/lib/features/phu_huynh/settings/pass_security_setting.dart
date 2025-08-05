import 'package:flutter/material.dart';
import 'package:mamnon/login/otp_screen.dart';

class PassSecuritySettingScreen extends StatefulWidget {
  const PassSecuritySettingScreen({super.key});

  @override
  State<PassSecuritySettingScreen> createState() =>
      _PassSecuritySettingScreenState();
}

class _PassSecuritySettingScreenState extends State<PassSecuritySettingScreen> {
  bool _eventNotification = true;
  bool _messageNotification = true;
  bool _updateNotification = true;
  bool _vibration = true;
  bool _doNotDisturb = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: ListView(
              children: [
                _buildSettingItem(
                  icon: 'assets/images/settings/change_pass.png',
                  title: 'Đổi mật khẩu',
                  value: _eventNotification,
                  onChanged: (val) => setState(() => _eventNotification = val),
                  showSwitch: false, //tắt Switch
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/PIN_request.png',
                  title: 'Yêu cầu mã PIN',
                  value: _messageNotification,
                  onChanged:
                      (val) => setState(() => _messageNotification = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/face_id.png',
                  title: 'Nhận diện khuôn mặt',
                  value: _updateNotification,
                  onChanged: (val) => setState(() => _updateNotification = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/touch_id.png',
                  title: 'Nhận diện vân tay',
                  value: _vibration,
                  onChanged: (val) => setState(() => _vibration = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/question.png',
                  title: 'Câu hỏi bảo mật',
                  value: _doNotDisturb,
                  onChanged: (val) => setState(() => _doNotDisturb = val),
                ),
              ],
            ),
          ),

          // Row chứa nút back và tiêu đề
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              children: [
                BackButtonCircle(),
                const SizedBox(width: 50),
                const Text(
                  'Mật khẩu và bảo mật',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    bool showSwitch = true, // 👈 thêm mặc định là true
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(icon, fit: BoxFit.cover),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing:
          showSwitch
              ? Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.teal,
              )
              : null, //không hiện gì nếu showSwitch là false
      onTap:
          showSwitch
              ? null
              : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OtpScreen()),
                );
              },
    );
  }
}

class BackButtonCircle extends StatelessWidget {
  final VoidCallback? onTap;

  const BackButtonCircle({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
