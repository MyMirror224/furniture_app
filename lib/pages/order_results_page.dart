import 'package:flutter/material.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/pages/Invoice_history_page.dart';
import 'package:furniture_app/pages/navigator_bar.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderResults extends HookConsumerWidget {
  final OrderModel order;
  final bool isSuccess; // Biến isSuccess xác định thành công hay thất bại
  const OrderResults({required this.isSuccess, required this.order, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    return Scaffold(
      // backgroundColor: Colors.green,oderfail
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: isSuccess
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/odersuccess.gif',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          "Thank you for your order",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff193d3d),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 330,
                        height: 250,
                        padding: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/oderfail.gif',
                          ),
                        ),
                      ),
                      Text(
                        'Sorry! The order has failed,',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 156, 37),
                        ),
                      ),
                      Text(
                        'please try again.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 156, 37),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: isSuccess
              ? Container(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                  color: Color.fromARGB(255, 131, 199, 199),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Order Id",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Address",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1.0,
                                  style: BorderStyle.solid, // Viền nét đứt
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.name,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color(0xff193d3d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    order.id.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color(0xff193d3d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    order.address.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color(0xff193d3d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút "Back Home" được nhấnHomeScreen
                            print('Back Home button pressed!');

                            // Chuyển về trang chủ
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xff193d3d),
                            backgroundColor: Colors.white,
                            elevation: 8.0,
                          ),
                          child: Text('Back Home'),
                        ),
                      ),
                      SizedBox(height: 10), // Khoảng cách giữa hai nút
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút "Track your order" được nhấn
                            print('Track your order button pressed!');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryInvoicePage(
                                    uid: userId.toString(),
                                  ),
                                ),
                                (route) => false);

                            // Chuyển sang trang mới
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xff193d3d),
                            elevation: 8.0,
                          ),
                          child: Text('Track your order'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                  color: Color.fromARGB(255, 216, 186, 122),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       "Name",
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     SizedBox(height: 5),
                            //     Text(
                            //       "Traking id",
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     SizedBox(height: 5),
                            //     Text(
                            //       "Payment code",
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     SizedBox(height: 5),
                            //     Text(
                            //       "Address",
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     SizedBox(height: 5),
                            //     Text(
                            //       "Date",
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1.0,
                                  style: BorderStyle.solid, // Viền nét đứt
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Error! The action is faulty or the order has not been updated",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color(0xff193d3d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "soft 404 error!",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color(0xff193d3d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Daytime: 16:37:52 06/04/2024",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color(0xff193d3d),
                                    ),
                                  ),
                                  // SizedBox(height: 5),
                                  // Text(
                                  //   "254 Nguyễn Tất Thành, Đà Nẵng",
                                  //   style: TextStyle(
                                  //     fontSize: 10,
                                  //     color: const Color(0xff193d3d),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 5),
                                  // Text(
                                  //   "05/04/2024",
                                  //   style: TextStyle(
                                  //     fontSize: 10,
                                  //     color: const Color(0xff193d3d),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút "Back Home" được nhấnHomeScreen
                            print('Back Home button pressed!');

                            // Chuyển về trang chủ
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xff193d3d),
                            backgroundColor: Colors.white,
                            elevation: 8.0,
                          ),
                          child: Text('Back Home'),
                        ),
                      ),
                      SizedBox(height: 10), // Khoảng cách giữa hai nút
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút "Track your order" được nhấn
                            print('Track your order button pressed!');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryInvoicePage(
                                  uid: userId.toString(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xff193d3d),
                            elevation: 8.0,
                          ),
                          child: Text('payment again'),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
