import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatelessWidget {
  final XFile? avatarFile;
  final String name;
  final String email;
  final VoidCallback onEdit;
  final VoidCallback? onAvatarTap;

  const ProfileHeader({
    super.key,
    this.avatarFile,
    required this.name,
    required this.email,
    required this.onEdit,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                avatarFile != null ? FileImage(File(avatarFile!.path)) : null,
            child: avatarFile == null
                ? Icon(Icons.person, size: 50, color: Colors.grey.shade400)
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onEdit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 225, 121, 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          ),
          child: const Text(
            'CHỈNH SỬA',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
