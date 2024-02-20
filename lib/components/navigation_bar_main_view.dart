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
        height: 60,
        backgroundColor: Color(0xff92b0a6), // nền dưới thanh navigation
        color: Color(0xff5d8374), // màu nền trên của navigation
        buttonBackgroundColor: Color(0xff193d3d), // nền của nút

        animationDuration:
            const Duration(milliseconds: 300), // thời gian chuyển màn hình
        animationCurve: Curves.easeInOutCirc, // kiểu chuyển màn hình

        items: const [
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.category, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
