import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/pages/navigator_bar.dart';

// ignore: camel_case_types
class evaluate extends StatelessWidget {
  const evaluate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Color.fromARGB(255, 88, 145, 145),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 1),
            child: Text(
              "Evaluate",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 88, 145, 145),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Submit thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color(0xff193d3d),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 88, 145, 145),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
