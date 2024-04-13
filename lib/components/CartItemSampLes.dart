
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemSampLess extends StatefulWidget {
  const CartItemSampLess({Key? key}) : super(key: key);

  @override
  _CartItemSampLessState createState() => _CartItemSampLessState();
}

class _CartItemSampLessState extends State<CartItemSampLess> {
  bool isChecked = false;

  int itemCount = 1;

  void incrementItemCount() {
    setState(() {
      itemCount = itemCount < 99 ? itemCount + 1 : itemCount;
    });
  }

  void decrementItemCount() {
    setState(() {
      itemCount = itemCount > 1 ? itemCount - 1 : itemCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 1; i < 4; i++)
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff193d3d),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: const Color(0xff193d3d),
                  onChanged: (bool? value) {
                    // Cập nhật giá trị của biến isChecked khi checkbox thay đổi trạng thái
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.asset("assets/images/1.png"),
                ),
                Container(
                  width: 120, // Giới hạn chiều rộng của Padding thành 70 width
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Relaxing bench and table",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          "\$1799",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.close,
                        color: Color(0xff193d3d), // Thay đổi màu sắc của Icon
                        size: 16, // Thay đổi kích thước của Icon
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: IconButton(
                      //     iconSize: 18, // Thay đổi kích thước của Icon
                      //     icon: Icon(
                      //       Icons.close,
                      //       color: Color.fromARGB(
                      //           255, 150, 150, 150), // Thay đổi màu sắc của Icon
                      //     ),
                      //     onPressed: () {
                      //       // Xử lý sự kiện khi nhấn nút X
                      //     },
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff193d3d),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: decrementItemCount,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff193d3d),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.minus,
                                    color: Colors.white,
                                    size: 8,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                itemCount.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff193d3d),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: incrementItemCount,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff193d3d),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.plus,
                                    color: Colors.white,
                                    size: 8,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
