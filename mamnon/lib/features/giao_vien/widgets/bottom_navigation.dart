import 'package:flutter/material.dart';

class BottomNavigationWidgetGiaoVien extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidgetGiaoVien({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [Icons.home, Icons.list_alt, Icons.person_outline];

    List<String> labels = ['Trang chủ', 'Ngoại khóa', 'Hồ sơ'];

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
                // Hiệu ứng nền khi chọn
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icons[index],
                              color:
                                  currentIndex == index
                                      ? Colors.black
                                      : Colors.grey[600],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              labels[index],
                              style: TextStyle(
                                fontSize: currentIndex == index ? 14 : 12,
                                fontWeight:
                                    currentIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color:
                                    currentIndex == index
                                        ? Colors.black
                                        : Colors.grey[600],
                              ),
                            ),
                          ],
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
