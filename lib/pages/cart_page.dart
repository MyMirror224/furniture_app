import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/components/CartItemSampLes.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/pages/address_page.dart';
import 'package:furniture_app/pages/navigator_bar.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
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
      ref.read(cartProvider.notifier).totalnotDiscount();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(cartProvider).carts;
    final total = ref.watch(cartProvider).carts.products?.total ?? 0;
    final totalBefore = ref.watch(cartProvider).totalBefore;
    final discount = ref.watch(cartProvider).discount;
    bool isContinue = total > 0;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemeState = ref.watch(themeNotifierProvider);
    final isHome = ref.watch(cartProvider).isHome;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                Row(
                  children: [
                    Gap(20),
                    Container(
                      height: width * .1,
                      width: width * .1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                          width * .08,
                        )),
                        color: Color(0xFF183D3D),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (isHome == true) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (route) => false);
                          } else {
                            Navigator.pop(context);
                            ref.read(cartProvider.notifier).setHome(true);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                          size: width * .1 / 2.66,
                        ),
                      ),
                    )
                  ],
                ),
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
                        Text(
                          context.loc.cart,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: appThemeState == ThemeMode.dark
                              ? Color(0xff193d3d)
                              : Color(0xff193d3d).withOpacity(0.5),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: appThemeState == ThemeMode.dark
                                ? Color(0xff193d3d)
                                : const Color(0xff193d3d).withOpacity(0.5),
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
                          context.loc.address,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: appThemeState == ThemeMode.dark
                              ? Color(0xff193d3d)
                              : const Color(0xff193d3d).withOpacity(0.5),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: appThemeState == ThemeMode.dark
                                ? Color(0xff193d3d)
                                : const Color(0xff193d3d).withOpacity(0.5),
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
                          context.loc.pay,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    context.loc.myCart,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: height / 2.1,
                  child: CartItemSampLess(
                    items: products.products?.items ?? [],
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
              ],
            ),
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
        height: height / 3.2,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                    context.loc.orderdetails,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 10),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.totalBefore,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        context.loc.discount,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        context.loc.shopping,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        context.loc.totalPrice,
                        style: TextStyle(
                          fontSize: 16,
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
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "\$${discount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        context.loc.free,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$${total ?? 0}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: height / 18,
              child: ElevatedButton(
                onPressed: () {
                  if (isContinue) {
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
                  } else {
                    Fluttertoast.showToast(
                      msg: context.loc.pleaseChoiceProduct,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0xff193d3d),
                      textColor: Colors.white,
                      fontSize: 20.0,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: isContinue ? Color(0xff193d3d) : Colors.grey,
                ),
                child: Text(context.loc.continuee),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
