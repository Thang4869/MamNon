import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as genai;
import '../models/message_model.dart';
import '../widgets/message_bubble_widget.dart';
import '../widgets/input_box_widget.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<MessageModel> _messages = [
    MessageModel(content: 'Xin chào! Tôi có thể giúp gì cho bạn?', isUser: false),
  ];

  final List<Content> _chatHistory = [];  // Sử dụng Content từ flutter_gemini

  Future<void> _handleSend(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(MessageModel(content: text, isUser: true));
    });

    // Thêm tin nhắn người dùng vào lịch sử
    _chatHistory.add(Content(role: 'user', parts: [Part.text(text)]));

    try {
      final gemini = Gemini.instance;
      final responseStream = gemini.streamChat(_chatHistory);  // Stream hội thoại đa lượt

      String botResponse = '';
      await for (final chunk in responseStream) {
        for (final part in chunk.content?.parts ?? []) {
          if (part is genai.TextPart) {  // Sử dụng genai.TextPart để tránh xung đột
            botResponse += part.text;
          }  // Bỏ qua các loại part khác nếu không phải text
        }
        setState(() {});  // Cập nhật UI nếu cần hiển thị theo dòng
      }

      if (botResponse.isNotEmpty) {
        setState(() {
          _messages.add(MessageModel(content: botResponse, isUser: false));
        });
        // Thêm phản hồi bot vào lịch sử
        _chatHistory.add(Content(role: 'model', parts: [Part.text(botResponse)]));
      } else {
        setState(() {
          _messages.add(MessageModel(content: 'Không nhận được phản hồi.', isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(MessageModel(content: 'Lỗi: $e', isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trợ lý Ảo - Chatbot Gemini'),
        backgroundColor: const Color(0xFFD0F5DF),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubbleWidget(message: _messages[index]);
              },
            ),
          ),
          InputBoxWidget(onSend: _handleSend),
        ],
      ),
    );
  }
}