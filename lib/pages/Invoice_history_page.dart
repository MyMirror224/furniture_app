import 'package:flutter/material.dart';
import 'package:furniture_app/components/Invoicehistory.dart';
import 'package:furniture_app/components/listhistory.dart';


// ignore: camel_case_types
class historyPage extends StatefulWidget {
  const historyPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _historyPageState createState() => _historyPageState();
}

// ignore: camel_case_types
class _historyPageState extends State<historyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String currentFilter =
      'All'; // Thay đổi kiểu dữ liệu của currentFilter và khởi tạo giá trị

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Invhistory(),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: const Color(0xff193d3d),
                unselectedLabelColor: Colors.black54,
                indicatorColor: const Color(0xff193d3d),
                indicatorPadding:
                    const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                tabs: const [
                  Tab(text: 'All(8)'),
                  Tab(text: 'Pending(3)'),
                  Tab(text: 'In Progress(4)'),
                  Tab(text: 'Completed(1)'),
                  Tab(text: 'Cancelled'),
                  Tab(text: 'Returned'),
                ],
                labelStyle: const TextStyle(fontSize: 16), // Tăng kích thước chữ cho Tab đã chọn
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                onTap: (index) {
                  setState(() {
                    switch (index) {
                      case 0:
                        currentFilter = 'All';
                        break;
                      case 1:
                        currentFilter = 'Pending';
                        break;
                      case 2:
                        currentFilter = 'In Progress';
                        break;
                      case 3:
                        currentFilter = 'Completed';
                        break;
                      case 4:
                        currentFilter = 'Cancelled';
                        break;
                      case 5:
                        currentFilter = 'Returned';
                        break;
                      default:
                        currentFilter = 'All';
                    }
                  });
                },
              ),
              SizedBox(
                height: 520,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    listhistorypage(
                        filter: 'All', currentFilter: currentFilter),
                    listhistorypage(
                        filter: 'Pending', currentFilter: currentFilter),
                    listhistorypage(
                        filter: 'In Progress', currentFilter: currentFilter),
                    listhistorypage(
                        filter: 'Completed', currentFilter: currentFilter),
                    listhistorypage(
                        filter: 'Cancelled', currentFilter: currentFilter),
                    listhistorypage(
                        filter: 'Returned', currentFilter: currentFilter),
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
