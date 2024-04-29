import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/pages/invoice_details_page.dart';
import 'package:furniture_app/state/order/order_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


// ignore: camel_case_types
class listhistorypage extends HookConsumerWidget {
  final String filter;
  final int currentFilter;
   // Thêm kiểu dữ liệu cho currentFilter

  const listhistorypage({super.key, required this.filter, required this.currentFilter});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    // Giả định danh sách các đơn hàng
    List<OrderShowUi> orders =  ref.watch(orderProvider).orders;

    // Lọc danh sách đơn hàng dựa trên bộ lọc hiện tại
    List<OrderShowUi> filteredOrders = orders.where((order) {
      if (currentFilter == 'All') {
        return true;
      } else {
        return order == currentFilter;
      }
    }).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1), // Khoảng cách 2 pixels với tab bar phía trên
      child: ListView.separated(
      itemCount: filteredOrders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemBuilder: (context, index) {
        OrderShowUi order = filteredOrders[index];

        return Container(
          color: Colors.grey.shade200,
          child: ListTile(
          leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${AppConstants.SERVER_API_URL}storage/" +
                                    order.image,
                              ),
                              fit: BoxFit.fill,
                            )),
                      ), // Hình ảnh đơn hàng
          title: Text(
            order.nameProduct!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ), // Tên đơn hàng
           subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                            Text(
                order.type,
                style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 121, 94, 94)),
              ),
              Row(
                children: [
                  Text('Price: ${order.price}',
                  style: const TextStyle(fontSize: 12,color: Color(0xff193d3d))),
                  const SizedBox(width: 8),
                  Text('Quantity: ${order.quantity}',
                  style: const TextStyle(fontSize: 12,color: Color(0xff193d3d))),
                ],
              ),
              const SizedBox(height: 4),
              // Text(
              //   order.isdone,
              //   style: const TextStyle(
              //     fontSize: 12,
              //     color: Color.fromARGB(255, 84, 154, 211),
              //   ),
              // ),
            ],
          ),    
          trailing: ElevatedButton(
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút xem chi tiết
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InvoicedetailsPage()),
                    );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(68, 24),
            ),
            child: const Text('Xem chi tiết',
            style: TextStyle(fontSize: 10),
            ),
          ),
        )
        );
      },
    )
  );
  }
  
}

