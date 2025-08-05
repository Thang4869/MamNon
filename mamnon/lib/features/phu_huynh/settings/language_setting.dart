import 'package:flutter/material.dart';

class LanguageSettingScreen extends StatefulWidget {
  const LanguageSettingScreen({super.key});

  @override
  State<LanguageSettingScreen> createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  final List<String> languages = const [
    'Tiếng Việt',
    'English (UK)',
    'English (US)',
    'Español',
    'Français',
    '中文',
    '日本語',
    '한국어',
    'Português',
    'Deutsch',
    'Русский',
    'Italiano',
    'ไทย',
    'हिन्दी',
    'العربية',
    'Türkçe',
    'Nederlands',
    'Bahasa Indonesia',
    'Melayu',
    'Polski',
  ];

  String _selectedLanguage = 'Tiếng Việt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Tiêu đề và nút back
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  BackButtonCircle(),
                  const SizedBox(width: 90),
                  const Text(
                    'Ngôn ngữ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Danh sách ngôn ngữ
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: ListView.separated(
                itemCount: languages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  final isSelected = _selectedLanguage == lang;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedLanguage = lang;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.grey[300] : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              lang,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.radio_button_checked,
                              color: Colors.blue,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
