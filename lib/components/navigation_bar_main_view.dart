import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationMainView extends ConsumerWidget {
  const NavigationMainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade200, // nền dưới thanh navigation
        animationDuration:
            const Duration(milliseconds: 300), // thời gian chuyển màn hình
        animationCurve: Curves.easeInOutCirc, // kiểu chuyển màn hình
        buttonBackgroundColor: Colors.black54, // nền của nút
        color: Colors.black, // màu nền trên của navigation
        items: const [
          Icon(Icons.favorite),
          Icon(Icons.category),
          Icon(Icons.home),
          Icon(Icons.shopping_cart),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
