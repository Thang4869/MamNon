import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _eventNotification = true;
  bool _messageNotification = true;
  bool _updateNotification = true;
  bool _vibration = true;
  bool _doNotDisturb = true;
  bool _showSoundOptions = false;
  String _selectedSound = 'Mặc định';

  final List<String> _soundOptions = ['Mặc định', 'Chuông', 'Bíp', 'Trống'];

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
                  icon: 'assets/images/settings/event_noti.png',
                  title: 'Thông báo sự kiện',
                  value: _eventNotification,
                  onChanged: (val) => setState(() => _eventNotification = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/mess_noti.png',
                  title: 'Thông báo tin nhắn',
                  value: _messageNotification,
                  onChanged:
                      (val) => setState(() => _messageNotification = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/update_noti.png',
                  title: 'Thông báo cập nhật',
                  value: _updateNotification,
                  onChanged: (val) => setState(() => _updateNotification = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/rung.png',
                  title: 'Rung',
                  value: _vibration,
                  onChanged: (val) => setState(() => _vibration = val),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(
                  icon: 'assets/images/settings/no_distrub.png',
                  title: 'Chế độ Không làm phiền',
                  value: _doNotDisturb,
                  onChanged: (val) => setState(() => _doNotDisturb = val),
                ),
                const SizedBox(height: 10),
                _buildSoundSetting(),
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
                const SizedBox(width: 55),
                const Text(
                  'Cài đặt thông báo',
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
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: SizedBox(
        width: 50, // chỉnh theo ý
        height: 50,
        child: Image.asset(
          icon,
          fit: BoxFit.cover, // 👈 đảm bảo ảnh sẽ lấp đầy box
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.teal,
      ),
    );
  }

  Widget _buildSoundSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: GestureDetector(
            onTap: () => setState(() => _showSoundOptions = !_showSoundOptions),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    'assets/images/settings/noti_sound.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Âm thanh thông báo',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Icon(_showSoundOptions ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (_showSoundOptions)
          ..._soundOptions.map(
            (sound) => RadioListTile<String>(
              title: Text(sound),
              value: sound,
              groupValue: _selectedSound,
              onChanged: (value) => setState(() => _selectedSound = value!),
            ),
          ),
      ],
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
