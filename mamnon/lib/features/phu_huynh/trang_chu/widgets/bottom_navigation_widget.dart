import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.notifications,
      Icons.chat_bubble_outline,
      Icons.person_outline,
    ];

    List<String> labels = ['Trang chủ', 'Thông báo', 'Chatbot', 'Hồ sơ'];

    return SizedBox(
      height: 88,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFD0F5DF),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(99, 111, 243, 164),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth / icons.length;

            return Stack(
              children: [
                // Nền hiệu ứng di chuyển
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment(
                    -1 + (currentIndex * 2 / (icons.length - 1)),
                    0,
                  ),
                  child: Container(
                    width: itemWidth,
                    height: 48,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(icons.length, (index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(index),
                        child: SizedBox(  // Giới hạn chiều cao cố định
                          height: 56,  // Đảm bảo chiều cao không vượt quá giới hạn
                          child: Column(
                            mainAxisSize: MainAxisSize.min,  // Giới hạn chiều cao tự nhiên
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (index == 1)
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      icons[index],
                                      color: currentIndex == index
                                          ? Colors.black
                                          : Colors.grey[600],
                                    ),
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Icon(
                                  icons[index],
                                  color: currentIndex == index
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                              const SizedBox(height: 4),
                              Text(
                                labels[index],
                                style: TextStyle(
                                  fontSize: currentIndex == index ? 14 : 12,
                                  fontWeight: currentIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: currentIndex == index
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,  // Ngăn text dài gây overflow
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}