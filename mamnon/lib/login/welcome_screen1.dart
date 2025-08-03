import 'package:flutter/material.dart';
import 'package:mamnon/login/login_screen.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Layer 1: login_img1.png
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.5, // chỉ chiếm nửa trên
              child: Image.asset(
                'assets/images/login_img1.png',
                fit: BoxFit.cover,
              ),
            ),

            // Layer 2: nền vàng (bo cong 2 góc trên)
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

            // Layer 4: nội dung (text + button), căn giữa, nằm trong nền vàng
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100), // đẩy lên một chút
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'CHÀO MỪNG TỚI\nTRƯỜNG MẦM NON\nXUÂN QUỲNH',
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
                    const SizedBox(height: 100),
                    SizedBox(
                      width: 280,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // xử lý khi nhấn nút
                          Navigator.of(context).push(_createRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF53B175),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Tiếp theo',
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
          ],
        ),
      ),
    );
  }
}

// quản lý chuyển trang
Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder:
        (context, animation, secondaryAnimation) => const LoginScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // từ bên phải
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
