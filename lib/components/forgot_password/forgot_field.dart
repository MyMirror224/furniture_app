import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordField extends StatefulWidget {
  final String nameField;
  final IconData icon;

  const PasswordField({
    Key? key,
    required this.nameField,
    required this.icon,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Gap(20),
          // Hiển thị icon
          Icon(
            widget.icon,
            color: Colors.grey[600],
          ),
          const Gap(20),
          // TextField để nhập mật khẩu
          Expanded(
            child: TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: widget.nameField,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
