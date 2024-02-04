import 'package:flutter/material.dart';

class InformationFields extends StatelessWidget {
  final String text;
  final String? type;
  const InformationFields({super.key, this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    if (type == 'field') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        margin: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );
    } else {
      return Container(
        alignment: Alignment.bottomLeft,
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      );
    }
  }
}
