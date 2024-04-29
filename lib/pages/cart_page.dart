import 'package:flutter/material.dart';
import 'package:furniture_app/components/CartItemSampLes.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/pages/address_page.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//import 'package:furniture_app/widgets/cartbottomnarbar.dart';
//import 'package:image/image.dart';

class CartPage extends ConsumerStatefulWidget {
  final String userIdProvider;
  const CartPage(this.userIdProvider, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartProvider.notifier).fetchCart(widget.userIdProvider);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(cartProvider).carts;
    final total = ref.watch(cartProvider).carts.products?.total;
    final totalBefore = ref.watch(cartProvider).totalBefore;
    final discount = ref.watch(cartProvider).discount;
    return Scaffold(
      appBar: AppBar(
        //remove back button
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
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
              HomeAppBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xff193d3d),
                          shape: BoxShape.circle,
                        ),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn vào icon
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Cart",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff193d3d),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 3,
                        color: const Color(0xff193d3d).withOpacity(0.5),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xff193d3d).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xff193d3d).withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.location_on,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn vào icon
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xff193d3d).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 3,
                        color: const Color(0xff193d3d).withOpacity(0.5),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xff193d3d).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xff193d3d).withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.payment,
                              size: 15,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn vào icon
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Pay",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xff193d3d).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: const Text(
                  "My Cart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 490,
                child: Expanded(
                  child: CartItemSampLess(
                    items: products.products?.items ?? [],
                  ),
                ),
              ),

              // Container(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: 150,
              //         padding: const EdgeInsets.all(4),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: const Color(0xff193d3d),
              //             width: 1,
              //           ),
              //           borderRadius: BorderRadius.circular(7),
              //         ),
              //         child: const Text(
              //           "Promo Code",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 20),
              //       Container(
              //         width: 150,
              //         padding: const EdgeInsets.all(4),
              //         decoration: BoxDecoration(
              //           color: const Color(0xff193d3d),
              //           borderRadius: BorderRadius.circular(7),
              //         ),
              //         child: const Text(
              //           "Apply",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 5),
                child: const Text(
                  "Order details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.only(
                    top: 15, right: 25, left: 25, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff193d3d),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total before",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Shopping",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Total price",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$$totalBefore",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "\$$discount",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Free",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${total ?? 0}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 0), // Điều chỉnh giá trị số để điều chỉnh khoảng cách
      //  child: SizedBox(
      //     height: 100, // Đặt kích thước chiều cao mong muốn
      //     child: ClipRRect(
      //       borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(20.0), // Điều chỉnh giá trị số để tạo góc cong mong muốn
      //         topRight: Radius.circular(20.0),
      //         bottomLeft: Radius.circular(20.0),
      //         bottomRight: Radius.circular(20.0),
      //       ),
      //       child: cartbottomnavbar(),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            ref.read(cartProvider.notifier).saveCartItem();
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddressPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff193d3d),
            elevation: 8.0,
          ),
          child: Text('Continue'),
        ),
      ),
    );
  }
}

Widget NoItems() {
  return const Center(
    child: Text('No items in cart'),
  );
}