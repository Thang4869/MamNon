import 'package:flutter/material.dart';

class NotificationSliderWidget extends StatefulWidget {
  const NotificationSliderWidget({super.key});

  @override
  State<NotificationSliderWidget> createState() => _NotificationSliderWidgetState();
}

class _NotificationSliderWidgetState extends State<NotificationSliderWidget> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/notification1.png',
    'assets/notification2.png',
    'assets/notification3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    //event ontap Notification page
                    print("Tapped notification ${index + 1}");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.black
                    : Colors.grey.withOpacity(0.4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
