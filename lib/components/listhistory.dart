import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/pages/invoice_details_page.dart';
import 'package:furniture_app/state/order/order_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: camel_case_types
class listhistorypage extends HookConsumerWidget {
  final String filter;
  final int currentFilter;
  // Thêm kiểu dữ liệu cho currentFilter

  const listhistorypage(
      {super.key, required this.filter, required this.currentFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Giả định danh sách các đơn hàng
    List<OrderModel> orders = ref.watch(orderProvider).orders;
    List<String> is_done = [
      'Pending',
      'Delivering',
      'Delivering',
      'Goods delivered',
      'Returned'
    ];

    // Lọc danh sách đơn hàng dựa trên bộ lọc hiện tại
    List<OrderModel> filteredOrders = orders.where((order) {
      if (currentFilter == 0 && filter == 'All') {
        return true;
      } else if (currentFilter == 1 && filter == 'Pending') {
        return order.is_done == currentFilter - 1;
      } else if (currentFilter == 2 && filter == 'Delivering') {
        return order.is_done == currentFilter ||
            order.is_done + 1 == currentFilter;
      } else if (currentFilter == 3 && filter == 'Goods delivered') {
        return order.is_done == currentFilter;
      } else if (currentFilter == 4 && filter == 'Returned') {
        return order.is_done == currentFilter;
      } else if (currentFilter == -1 && filter == 'Cancelled') {
        return order.is_done == currentFilter;
      }
      return false;
    }).toList();

    return Container(
        // Khoảng cách 2 pixels với tab bar phía trên
        child: ListView.separated(
      itemCount: filteredOrders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemBuilder: (context, index) {
        OrderModel order = filteredOrders[index];
        return Container(
            height: 130,
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
                            order.products[0].image,
                      ),
                      fit: BoxFit.fill,
                    )),
              ), // Hình ảnh đơn hàng
              title: Text(
                'Order Number: ${order.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ), // Tên đơn hàng
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(10),
                  Text(
                    order.type,
                    style: const TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 121, 94, 94)),
                  ),
                  Gap(10),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price: ${order.total_price}',
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xff193d3d))),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.is_done >= 0
                        ? '${is_done[order.is_done]}'
                        : 'Cancelled',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 84, 154, 211),
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  print(order.products.length);
                  // Xử lý sự kiện khi nhấn nút xem chi tiết
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvoicedetailsNotCofirmPage(
                              order: order,
                              products: order.products,
                              is_done: order.is_done >= 0
                                  ? is_done[order.is_done]
                                  : 'Cancelled',
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(68, 24),
                ),
                child: const Text(
                  'View Detail',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ));
      },
    ));
  }
}
