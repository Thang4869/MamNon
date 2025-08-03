import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mamnon/login/login_screen.dart';

class ChangePassScreen extends StatefulWidget {
  final String email;
  const ChangePassScreen({super.key, required this.email});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _obscurePasswordNew = true;
  bool _obscurePasswordConfirm = true;
  String errorText = '';

  Future<void> _changePassword() async {
    final newPass = _newPassController.text.trim();
    final confirmPass = _confirmPassController.text.trim();

    if (newPass != confirmPass) {
      setState(() {
        errorText = 'Mật khẩu không khớp';
      });
      return;
    }

    final url = Uri.parse('http://10.0.2.2:5005/api/phuhuynhs');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = List.from(jsonDecode(response.body));

      final ph = data.firstWhere(
        (item) => item['email'].toString().trim() == widget.email,
        orElse: () => null,
      );

      if (ph != null) {
        final updated = {...ph, 'matKhau': newPass};

        final putUrl = Uri.parse(
          'http://10.0.2.2:5005/api/phuhuynhs/${ph["idPh"].toString().trim()}',
        );
        final putRes = await http.put(
          putUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(updated),
        );

        if (putRes.statusCode == 204 || putRes.statusCode == 200) {
          // Đổi mật khẩu thành công
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              _createRoute(const LoginScreen()),
            );
          }
        } else {
          setState(() {
            errorText = 'Đổi mật khẩu thất bại.';
          });
        }
      } else {
        setState(() {
          errorText = 'Không tìm thấy email!';
        });
      }
    } else {
      setState(() {
        errorText = 'Lỗi kết nối server.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.5,
              child: Image.asset(
                'assets/images/login_img1.png',
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),

            Positioned(
              top: size.height * 0.45,
              left: 0,
              right: 0,
              height: size.height * 0.55,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFCCB47E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 55,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'TRƯỜNG MẦM NON\nXUÂN QUỲNH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                        letterSpacing: -0.28,
                      ),
                    ),
                    const SizedBox(height: 30),

                    _buildPasswordField(
                      controller: _newPassController,
                      hintText: 'Mật khẩu mới',
                      obscure: _obscurePasswordNew,
                      onToggle: () {
                        setState(
                          () => _obscurePasswordNew = !_obscurePasswordNew,
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildPasswordField(
                      controller: _confirmPassController,
                      hintText: 'Xác nhận mật khẩu',
                      obscure: _obscurePasswordConfirm,
                      onToggle: () {
                        setState(
                          () =>
                              _obscurePasswordConfirm =
                                  !_obscurePasswordConfirm,
                        );
                      },
                    ),

                    if (errorText.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF53B175),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Thay đổi',
                          style: TextStyle(
                            fontSize: 20,
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
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
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
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 40,
                height: 24,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFECE2E2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment:
                      obscure ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
