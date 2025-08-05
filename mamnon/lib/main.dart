import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'app.dart';

const String apiKey = 'AIzaSyA54HUSSqwsi0KDI1O1vkVA1w1mKYukoW8';  // Thay bằng khóa thực tế từ Google AI Studio

void main() {
  try {
    Gemini.init(apiKey: apiKey);  // Khởi tạo với API key
    print('Gemini initialized with API key: $apiKey');  // Xác nhận khởi tạo
  } catch (e) {
    print('Failed to initialize Gemini: $e');  // Log lỗi khởi tạo
  }
  runApp(const MamNonApp());
}