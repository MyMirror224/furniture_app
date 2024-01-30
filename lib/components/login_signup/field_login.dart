import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget myTextField(IconData icon, String hintText,TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 25,
      right: 25,
    ),
    child: Container(
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Gap(10),
          Icon(
            icon,
            size: 30,
            color: Colors.grey[600],
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.black),
              obscureText:
                  hintText == 'Password' || hintText == 'Confirm Password'
                      ? true
                      : false,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
        ],
      ),
    ),
  );
}
