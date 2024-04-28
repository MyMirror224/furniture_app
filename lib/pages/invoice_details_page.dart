// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/components/details.dart';

import 'package:gap/gap.dart';
import 'package:flutter/services.dart';

//import 'package:furniture_app/widgets/cartbottomnarbar.dart';
//import 'package:image/image.dart';

class InvoicedetailsPage extends StatelessWidget {
  const InvoicedetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const nameInvoicede(),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 145, 145),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đơn hàng giao thành công',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Gap(5),
                          Text(
                            '12:02:23 07/04/2024',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'assets/images/thongtindonhang.gif', // Đường dẫn tới hình ảnh của bạn
                        width: 100.0, // Chiều rộng của hình ảnh
                        height: 90.0, // Chiều cao của hình ảnh
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        'assets/images/xegiaohang.png',
                        width: 24.0,
                        height: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thông tin vận chuyển',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Cấp tốc',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        'assets/images/toado.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Địa chỉ nhận hàng',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'DungVo',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            '099-559-7777',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            '254 Nguyễn Tất Thành, Đà Nẵng',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(const ClipboardData(
                            text:
                                'DungVo\n099-559-7777\n254 Nguyễn Tất Thành, Đà Nẵng'));
                        Fluttertoast.showToast(
                          msg: "Đã sao chép",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xff193d3d),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: "Đã sao chép",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: const Color(0xff193d3d),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                // decoration: const BoxDecoration(
                //   border: Border(
                //     bottom: BorderSide(
                //       color: Colors.grey,
                //       width: 1.0,
                //     ),
                //   ),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          child:
                              Image.asset("assets/images/1.png"), // Màu nền ảnh
                          // Thay thế ảnh bằng widget Image thực tế
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Relaxing bench and table',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              RichText(
                                text: TextSpan(
                                  text: 'color green, length 1m3',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 10.0,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: ' - sale 40%',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Quantity: x1', // Số lượng sản phẩm
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                padding: const EdgeInsets.only(
                    top: 5, right: 10, left: 10, bottom: 15),
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: const Color(0xff193d3d),
                //     width: 1,
                //   ),
                //   borderRadius: BorderRadius.circular(7),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tolal before",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "discount",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "shopping",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Tax",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "total price",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$5990",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$500",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "free",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$100",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "\$9900",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 7.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                padding: const EdgeInsets.only(
                    top: 10, right: 25, left: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff193d3d),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons
                          .credit_card, // Icon thẻ Visa (thay thế bằng biểu tượng Visa thực tế)
                      color: Colors.black,
                      size: 24.0,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phương thức thanh toán',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Thanh toán khi nhận hàng',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 7.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10), // Lề trái, trên, phải, dưới đều là 5px
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mã đơn hàng',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            'thời gian đặt hàng',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            'thời gian thanh toán',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            'thời gian hoàn thành',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '387df9237d932',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            '06/04/2024 03:34',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            '07/04/2024 13:08',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            '09/04/2024 09:59',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 5, left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            // Xử lý khi nhấn nút liên hệ shop
                          },
                          icon: const Icon(Icons.messenger),
                          label: const Text('Liên hệ shop'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xff193d3d),
                            backgroundColor: Colors.white, // Màu văn bản xanh
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xff193d3d),
                              ), // Viền màu xanh
                              borderRadius:
                                  BorderRadius.circular(8.0), // Bo góc viền
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Xử lý khi nhấn nút xem đánh giá
                          },
                          icon: const Icon(Icons.star),
                          label: const Text('Đánh giá SP'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xff193d3d),
                            backgroundColor: Colors.white, // Màu văn bản xanh
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color(0xff193d3d)), // Viền màu xanh
                              borderRadius:
                                  BorderRadius.circular(8.0), // Bo góc viền
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
