import 'package:flutter/material.dart';

// ignore: camel_case_types
class nameInvoicede extends StatelessWidget {
  const nameInvoicede({super.key});

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
              "Invoice details",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // const Spacer(), // Thêm Spacer để tạo khoảng trống giữa Text và IconButton
          // IconButton(
          //   icon: const Icon(
          //     Icons.card_giftcard_sharp,
          //     size: 30,
          //     color: Color.fromARGB(255, 88, 145, 145),
          //   ),
          //   onPressed: () {
          //     // Xử lý khi nhấp vào biểu tượng "home" ở đây
          //     // Chuyển về trang chủ
          //     Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => HomeScreen()),
          //           );
          //   },
          // ),
        ],
      ),
    );
  }
}