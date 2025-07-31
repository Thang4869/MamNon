import 'package:flutter/material.dart';
import '../models/child.dart';

class SoBuoiVangScreen extends StatelessWidget {
  final Child child;

  const SoBuoiVangScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final int soBuoiVang = child.result - child.attendance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin ngày vắng học',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xFFD0F5DF),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD0F5DF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: soBuoiVang > 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bé ${child.name} đã nghỉ học $soBuoiVang ngày.',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      //danh sách ngày nghỉ 
                    ],
                  )
                : const Text(
                    'Bé đi học đầy đủ!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
