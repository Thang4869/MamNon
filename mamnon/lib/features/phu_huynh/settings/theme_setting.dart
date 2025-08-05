import 'package:flutter/material.dart';

class ThemeSettingScreen extends StatefulWidget {
  const ThemeSettingScreen({super.key});

  @override
  State<ThemeSettingScreen> createState() => _ThemeSettingScreenState();
}

class _ThemeSettingScreenState extends State<ThemeSettingScreen> {
  String selectedTheme1 = 'Trung bình';
  String selectedTheme2 = 'Mặc định';
  String selectedTheme3 = 'Mặc định';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  BackButtonCircle(),
                  const SizedBox(width: 90),
                  const Text(
                    'Giao diện',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SettingOptionBox(
              imagePath: 'assets/images/settings/text_size.png',
              title: 'Kích thước chữ',
              options: const ['Nhỏ', 'Trung bình', 'Lớn'],
              selectedOption: selectedTheme1,
              onOptionSelected: (option) {
                setState(() {
                  selectedTheme1 = option;
                });
              },
            ),
            SettingOptionBox(
              imagePath: 'assets/images/settings/color_theme.png',
              title: 'Chủ đề màu sắc',
              options: const ['Mặc định', 'Sáng', 'Tối'],
              selectedOption: selectedTheme2,
              onOptionSelected: (option) {
                setState(() {
                  selectedTheme2 = option;
                });
              },
            ),
            SettingOptionBox(
              imagePath: 'assets/images/settings/text_style.png',
              title: 'Phong cách chữ',
              options: const ['Mặc định', 'Sans - serif', 'Serif'],
              selectedOption: selectedTheme3,
              onOptionSelected: (option) {
                setState(() {
                  selectedTheme3 = option;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingOptionBox extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionSelected;

  const SettingOptionBox({
    super.key,
    required this.imagePath,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề có hình
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Image.asset(
                    imagePath,
                    width: 45, // hoặc nhỏ hơn nếu ảnh của bạn to
                    height: 45,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        size: 20,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Các lựa chọn
          ...options.map((option) {
            final isSelected = option == selectedOption;
            return GestureDetector(
              onTap: () => onOptionSelected(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey.shade300 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 18,
                      color: isSelected ? Colors.black87 : Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class BackButtonCircle extends StatelessWidget {
  final VoidCallback? onTap;

  const BackButtonCircle({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              offset: const Offset(2, 2),
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
    );
  }
}
