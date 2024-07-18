import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onLogout;

  const LogoutDialog({
    super.key,
    required this.onCancel,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff0C54BE),
      title: const Text(
        'Log Out',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      content: const Text(
        'Are you sure you want to log out?',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: onLogout,
          child: const Text(
            'Log Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
