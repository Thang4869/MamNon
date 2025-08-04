import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final bool isEditing;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const ProfileForm({
    super.key,
    required this.isEditing,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          enabled: isEditing,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: phoneController,
          enabled: isEditing,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.phone),
            labelText: 'Số điện thoại',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
