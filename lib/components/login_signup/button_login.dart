import 'package:flutter/material.dart';

Widget buttonLogin(String text, Color color, int x, int y,
    {Function()? onpressed}) {
  return ElevatedButton(
    onPressed: onpressed,
    child: Text(text, style: const TextStyle(fontSize: 20)),
    style: ElevatedButton.styleFrom(
      // primary: Colors.grey,
      // onPrimary: Colors.white,
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: Size(x.toDouble(), y.toDouble()),
    ),
  );
}
