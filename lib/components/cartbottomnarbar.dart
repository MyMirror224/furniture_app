import 'package:flutter/material.dart';

class cartbottomnavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xff193d3d).withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    color: const Color(0xff193d3d),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$4999",
                  style: TextStyle(
                    color: const Color(0xff193d3d),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Các widget khác trong dòng này
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi nhấn vào button
                // Chuyển trang tại đây
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 0),
                backgroundColor: const Color(0xff193d3d), // Màu nền là màu xanh
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 2), // Khoảng cách giữa dòng và button
          ],
        ),
      ),
    );
  }
}
