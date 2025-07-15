import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessageBubbleWidget extends StatelessWidget {
  final MessageModel message;

  const MessageBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment = message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final bgColor = message.isUser ? Colors.orange[200] : Colors.grey[200];
    final textColor = Colors.black;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message.content, style: TextStyle(color: textColor)),
      ),
    );
  }
}
