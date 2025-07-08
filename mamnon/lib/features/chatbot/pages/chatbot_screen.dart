import 'package:flutter/material.dart';
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

  void _handleSend(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(MessageModel(content: text, isUser: true));
      _messages.add(MessageModel(content: 'Đây là phản hồi từ chatbot.', isUser: false)); // giả lập phản hồi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trợ lý Ảo - Chatbot'),
        backgroundColor: Colors.orange,
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
