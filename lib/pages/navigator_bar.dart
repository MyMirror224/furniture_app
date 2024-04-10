
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/pages/category_page.dart';
import 'package:furniture_app/pages/chat_page.dart';
import 'package:furniture_app/pages/giff_box_page.dart';
import 'package:furniture_app/pages/home_page.dart';
import 'package:furniture_app/pages/personal/personal.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  final TextEditingController searchController = TextEditingController();

  int index = 2;
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final co = ref.watch(inforProvider);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: const Color.fromARGB(
            255, 255, 255, 255), // nền dưới thanh navigation
        color: const Color(0xff5d8374), // màu nền trên của navigation
        buttonBackgroundColor: const Color(0xff193d3d), // nền của nút

        animationDuration:
            const Duration(milliseconds: 300), // thời gian chuyển màn hình
        animationCurve: Curves.easeInOutCirc, // kiểu chuyển màn hình
        index: index,
        onTap: (selectIndex) {
          index = selectIndex;
          co.setIndex(selectIndex);
        },
        items: const [
          Icon(Icons.category, size: 30, color: Colors.white),
          Icon(Icons.card_giftcard, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.chat, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
      body: Container(
        child: getSelectWidget(index: index),
      ),
    );
  }

  Widget getSelectWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = listPage.elementAt(index);
        break;
      case 1:
        widget = listPage.elementAt(index);
        break;
      case 2:
        widget = listPage.elementAt(index);
        break;
      case 3:
        widget = listPage.elementAt(index);
        break;
      case 4:
        widget = listPage.elementAt(index);
        break;
      default:
        widget = listPage.elementAt(index);
        break;
    }
    return widget;
  }
}

final inforProvider = ChangeNotifierProvider((ref) => InforProvider());

class InforProvider extends ChangeNotifier {
  int index = 2;
  void setIndex(int selectIndex) {
    index = selectIndex;
    notifyListeners();
  }
}



List<Widget>  listPage =[
   CategoryPage(),
   GiftBoxPage(),
   HomePage(),
   ChatPage(),
   const PersonalPage(),
];