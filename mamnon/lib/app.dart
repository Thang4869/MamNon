import 'package:flutter/material.dart';
import 'routes/quan_ly_duong_dan.dart';

class MamNonApp extends StatelessWidget {
  const MamNonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mam Non App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: QuanLyDuongDan.routes,
    );
  }
}