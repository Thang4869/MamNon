import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'change_pass_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  String _errorMessage = '';
  bool _otpSent = false;

  Future<void> _sendOtp() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _errorMessage = 'Vui lòng nhập email');
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5005/api/ForgetPassApi/send-otp'),
      //'http://192.168.68.140:5005/api/ForgetPassApi/send-otp' Thắng
      //'http://10.0.2.2:5005/api/ForgetPassApi/send-otp' Thuận
      //'http://localhost:5005/api/ForgetPassApi/send-otp'
      headers: {'Content-Type': 'application/json'},
      body: json.encode(email),
    );

    if (response.statusCode == 200) {
      setState(() {
        _otpSent = true;
        _errorMessage = '';
      });
    } else {
      setState(() => _errorMessage = 'Email không tồn tại hoặc lỗi gửi');
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    final email = _emailController.text.trim();

    if (otp.isEmpty || email.isEmpty) {
      setState(() => _errorMessage = 'Vui lòng nhập đầy đủ email và OTP');
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5005/api/ForgetPassApi/send-otp'),
      //'http://192.168.68.140:5005/api/ForgetPassApi/send-otp'
      //'http://10.0.2.2:5005/api/ForgetPassApi/send-otp'
      //'http://localhost:5005/api/ForgetPassApi/send-otp'
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "otp": otp}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangePassScreen(email: email)),
      );
    } else {
      setState(() => _errorMessage = 'Mã OTP không đúng');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD0F5DF), Color(0xFFFFFFFF)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const Spacer(),
                      const Text(
                        'THAY ĐỔI MẬT KHẨU',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 80),
                  _buildInputField(_emailController, 'Email'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildInputField(_otpController, 'OTP'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: _sendOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6BB5ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Gửi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF53B175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        shadowColor: Colors.black.withOpacity(0.25),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
