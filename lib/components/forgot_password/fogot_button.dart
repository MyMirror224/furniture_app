import 'package:flutter/material.dart';

class ForgotButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const ForgotButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, // chua co
      child: Text(text, style: const TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(150, 50),
      ),
    );
  }
}
