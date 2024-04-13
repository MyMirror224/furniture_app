import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_app/components/addressss.dart';
import 'package:furniture_app/pages/payment_page.dart';

import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

//import 'package:image/image.dart';

// ignore: camel_case_types
class address08 extends StatefulWidget {
  const address08({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _address08State createState() => _address08State();
}

TextEditingController textController = TextEditingController();
bool isTextFieldEmpty = true;

// ignore: camel_case_types
class _address08State extends State<address08> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool isDefault = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          adressss(),
          Container(
            //height: 800,
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Cart",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: const Color(0xff193d3d),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: Color(0xff193d3d).withOpacity(0.5),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff193d3d).withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.payment,
                                size: 15,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Pay",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Define data",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                //CartItemSampLess(),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa Text và TextField
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff193d3d)
                                  .withOpacity(0.5)), // Màu viền xanh
                          borderRadius: BorderRadius.circular(7),
                          // Bo góc viền
                        ),
                        child: TextField(
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff193d3d)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    15), // Khoảng cách giữa viền và nội dung TextField
                            border: InputBorder
                                .none, // Bỏ viền mặc định của TextField
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Number",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                          height: 8), // Khoảng cách giữa Text và TextField
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff193d3d).withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff193d3d)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery address",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Gap(8), // Khoảng cách giữa Text và TextField
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff193d3d)
                                  .withOpacity(0.5)), // Màu viền xanh
                          borderRadius: BorderRadius.circular(7),
                          // Bo góc viền
                        ),
                        child: TextField(
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff193d3d)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    15), // Khoảng cách giữa viền và nội dung TextField
                            border: InputBorder
                                .none, // Bỏ viền mặc định của TextField
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 15, top: 15),
                //   child: Text(
                //     "Setting",
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.only(left: 15, top: 5, right: 15),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Address type:",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //           color: Colors.black,
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //       Expanded(
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.end,
                //               children: [
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     Text(
                //                       "Văn phòng",
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                         color: Color(0xff193d3d),
                //                       ),
                //                     ),
                //                     Checkbox(
                //                       value:
                //                           false, // Giá trị của checkbox "văn phòng"
                //                       onChanged: (bool? value) {
                //                         // Xử lý sự kiện khi checkbox "văn phòng" thay đổi
                //                       },
                //                     ),
                //                   ],
                //                 ),
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     Text(
                //                       "Nhà riêng",
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                         color: Color(0xff193d3d),
                //                       ),
                //                     ),
                //                     Checkbox(
                //                       value:
                //                           false, // Giá trị của checkbox "nhà riêng"
                //                       onChanged: (bool? value) {
                //                         // Xử lý sự kiện khi checkbox "nhà riêng" thay đổi
                //                       },
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "Delivery time:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              selectedDate != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(selectedDate!)
                                  : 'Select date',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              selectedTime != null
                                  ? selectedTime!.format(context)
                                  : 'Select time',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 170, top: 10, right: 15, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "set as default",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff193d3d),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Switch(
                        value: isDefault,
                        onChanged: (value) {
                          setState(() {
                            isDefault = value;
                          });
                        },
                        activeColor: Color(0xff193d3d),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Message:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Gap(8), // Khoảng cách giữa Text và TextField
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff193d3d).withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Stack(
                          children: [
                            TextField(
                              controller: textController,
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff193d3d)),
                              onChanged: (value) {
                                setState(() {
                                  isTextFieldEmpty = value.isEmpty;
                                });
                              },
                              maxLines: null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 15,
                              child: Opacity(
                                opacity: isTextFieldEmpty
                                    ? 1.0
                                    : 0.0, // Điều chỉnh độ mờ của dòng chữ
                                child: Text(
                                  'Note to the sender...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //       topRight: Radius.circular(20),
                //     ),
                //   ),
                //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       RichText(
                //         text: TextSpan(
                //           children: [
                //             TextSpan(
                //               text: "Bằng cách nhấn tiếp tục, bạn đồng ý với ",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.normal,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             TextSpan(
                //               text: "Điều Khoản Sử dụng",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             TextSpan(
                //               text:
                //                   " app bán đồ nội thất Capstone và xác nhận rằng bạn đã đọc ",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.normal,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             TextSpan(
                //               text: "Chính Sách Quyền riêng tư của Capstone",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             TextSpan(
                //               text:
                //                   ". Địa chỉ sẽ được pipo xử lý riêng theo chính sách quyền riêng tư của Capstone.",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.normal,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ],
                //         ),
                //         maxLines: 4,
                //         overflow: TextOverflow.ellipsis,
                //         textAlign: TextAlign.justify,
                //         strutStyle: StrutStyle(height: 1.5),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            // Xử lý sự kiện khi nút "Continue" được nhấn
            print('Continue button pressed!');

            // Chuyển sang trang mới
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff193d3d),
            elevation: 8.0,
          ),
          child: Text('Continue'),
        ),
      ),
    );
  }
}
