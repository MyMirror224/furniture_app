import 'package:flutter/material.dart';
import 'package:furniture_app/components/Invoicehistory.dart';
import 'package:furniture_app/components/listhistory.dart';
import 'package:furniture_app/state/order/order_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: must_be_immutable
class HistoryInvoicePage extends ConsumerStatefulWidget {
  final String uid;
   const HistoryInvoicePage({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends ConsumerState<HistoryInvoicePage> with TickerProviderStateMixin {
 late TabController _tabController;
  @override
  void didChangeDependencies() {
    _tabController = TabController(length: 6, vsync: this);
    Future.delayed(const Duration(seconds: 3), () {
      ref.read(orderProvider).fetchOrder(widget.uid);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
   int currentFilter = ref.watch(orderProvider).currentFilter;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                    Tab(text: 'All'),
                    Tab(text: 'Pending'),
                    Tab(text: 'Delivering'),
                    Tab(text: 'Goods delivered'),
                    Tab(text: 'Returned'),
                    Tab(text: 'Cancelled'),
                  ],
                  labelStyle: const TextStyle(fontSize: 16), // Tăng kích thước chữ cho Tab đã chọn
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  onTap: (index) {
                    
                      switch (index) {
                        case 0:
                          ref.read(orderProvider.notifier).setCurrentFilter(0);
                          break;
                        case 1:
                         
                           ref.read(orderProvider.notifier).setCurrentFilter(1);
                          break;
                        case 2:
                        
                          ref.read(orderProvider.notifier).setCurrentFilter(2);
                          break;
                        case 3:
                          
                          ref.read(orderProvider.notifier).setCurrentFilter(3);
                          break;
                        case 4:
                           ref.read(orderProvider.notifier).setCurrentFilter(4);
                          
                          break;
                        case 5:
                          ref.read(orderProvider.notifier).setCurrentFilter(-1);
                         
                          break;
                        default:
                          ref.read(orderProvider.notifier).setCurrentFilter(0);
                      }
                   
                  },
                ),
                SizedBox(
                  height: height * 0.9,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      listhistorypage(
                          filter: 'All', currentFilter: currentFilter),
                      listhistorypage(
                          filter: 'Pending', currentFilter: currentFilter),
                      listhistorypage(
                          filter: 'Delivering', currentFilter: currentFilter),
                      listhistorypage(
                          filter: 'Goods delivered', currentFilter: currentFilter),
                      listhistorypage(
                          filter: 'Returned', currentFilter: currentFilter),
                      listhistorypage(
                          filter: 'Cancelled', currentFilter: currentFilter),
                    ],
                  ),
                ),
      
              ],
            ),
          ),
        ),
      ),
    );

  }
  }
// ignore: camel_case_types
