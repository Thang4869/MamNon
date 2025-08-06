import 'package:flutter/material.dart';

class ChiTietHoSoGiaoVienScreen extends StatelessWidget {
  final Map userInfo;

  const ChiTietHoSoGiaoVienScreen({super.key, required this.userInfo});

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value.isNotEmpty ? value : '—'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết hồ sơ'),
        backgroundColor: const Color(0xFFD0F5DF),
        elevation: 0,
      ),
      body: Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Avatar + Tên
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: userInfo['avatarUrl'] != null
                        ? NetworkImage(userInfo['avatarUrl'])
                        : null,
                    child: userInfo['avatarUrl'] == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userInfo['hoTen'] ?? 'Chưa có tên',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1),

                  // Thông tin chi tiết
                  _buildInfoTile(Icons.cake, 'Năm sinh',
                      userInfo['namSinh']?.toString() ?? ''),
                  _buildInfoTile(Icons.work, 'Năm làm',
                      userInfo['namLam']?.toString() ?? ''),
                  _buildInfoTile(Icons.phone, 'SĐT',
                      userInfo['sdt']?.toString() ?? ''),
                  _buildInfoTile(Icons.email, 'Email',
                      userInfo['email']?.toString() ?? ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
