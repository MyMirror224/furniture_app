import 'package:flutter/material.dart';

Widget buttonLogin(String text, Color color, {Function()? onpressed}) {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: TextButton(
              onPressed: onpressed,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ),
    ),
  );
}
