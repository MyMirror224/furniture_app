import 'package:flutter/material.dart';
import 'package:furniture_app/pages/invoice_details_page.dart';


// ignore: camel_case_types
class listhistorypage extends StatelessWidget {
  final String filter;
  final String currentFilter; // Thêm kiểu dữ liệu cho currentFilter

  const listhistorypage({super.key, required this.filter, required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    // Giả định danh sách các đơn hàng
    List<Order> orders = [
      Order(
        image: 'assets/images/1.png',
        name: 'Double chair',
        price: 100,
        quantity: 2,
        status: 'Pending',
        description: 'Green, 1M7 long',
      ),
      Order(
        image: 'assets/images/1.png',
        name: 'Bed chair',
        price: 150,
        quantity: 1,
        status: 'In Progress',
        description: 'White, double chair',
      ),
      Order(
        image: 'assets/images/1.png',
        name: 'Blue sofa set',
        price: 80,
        quantity: 3,
        status: 'Completed',
        description: 'White, double chair',
      ),
            Order(
        image: 'assets/images/1.png',
        name: 'Gaming chair',
        price: 200,
        quantity: 2,
        status: 'Pending',
        description: 'White, double chair',
      ),
      Order(
        image: 'assets/images/1.png',
        name: 'Classic style tables and chairs',
        price: 300,
        quantity: 1,
        status: 'Pending',
        description: 'White, double chair',
      ),
            Order(
        image: 'assets/images/1.png',
        name: 'Bed chair',
        price: 150,
        quantity: 1,
        status: 'In Progress',
        description: 'White, double chair',
      ),
            Order(
        image: 'assets/images/1.png',
        name: 'Bed chair',
        price: 150,
        quantity: 1,
        status: 'In Progress',
        description: 'White, double chair',
      ),
            Order(
        image: 'assets/images/1.png',
        name: 'Bed chair',
        price: 150,
        quantity: 1,
        status: 'In Progress',
        description: 'White, double chair',
      ),
    ];

    // Lọc danh sách đơn hàng dựa trên bộ lọc hiện tại
    List<Order> filteredOrders = orders.where((order) {
      if (currentFilter == 'All') {
        return true;
      } else {
        return order.status == currentFilter;
      }
    }).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1), // Khoảng cách 2 pixels với tab bar phía trên
      child: ListView.separated(
      itemCount: filteredOrders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemBuilder: (context, index) {
        Order order = filteredOrders[index];

        return Container(
          color: Colors.grey.shade200,
          child: ListTile(
          leading: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(order.image),
          ), // Hình ảnh đơn hàng
          title: Text(
            order.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ), // Tên đơn hàng
           subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                            Text(
                order.description,
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
              Text(
                order.status,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 84, 154, 211),
                ),
              ),
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

class Order {
  final String image;
  final String name;
  final double price;
  final int quantity;
  final String status;
  final String description;
  Order({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.status,
    required this.description,
  });
}