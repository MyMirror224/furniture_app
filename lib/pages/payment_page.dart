import 'package:flutter/material.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/pages/order_results_page.dart';
import 'package:furniture_app/pages/pay_online_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _cart = ref.watch(cartProvider);
    final userId = ref.watch(userIdProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                    Text(
                      context.loc.cart,
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
                      color: const Color(0xff193d3d),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "",
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
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xff193d3d),
                        shape: BoxShape.circle,
                      ),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(
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
                    SizedBox(height: 5),
                    Text(
                      context.loc.address,
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
                      color: Color(0xff193d3d),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "",
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
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xff193d3d),
                        shape: BoxShape.circle,
                      ),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.payment,
                            size: 15,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Xử lý sự kiện khi nhấn vào icon
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      context.loc.pay,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xff193d3d),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child:  Text(context.loc.inforOrder,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xff93b1a7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.loc.name}: ${_cart.nameController.text}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Gap(5),
                      Text(
                        '${context.loc.phone}: ${_cart.phoneController.text}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Gap(5),
                      Text(
                        '${context.loc.address}: ${_cart.addressController.text}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Gap(5),
                      Text(
                        '${context.loc.message}: ${_cart.messageController}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ]),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.cartItemsShow.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color(0xff93b1a7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                          )
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(20),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${context.loc.name}: ${_cart.cartItemsShow[index].name.toString().substring(_cart.cartItemsShow[index].name!.indexOf(' '))}'),
                                Gap(5),
                                Text(
                                    '${context.loc.quantity}: ${_cart.cartItemsShow[index].quantity}'),
                                Gap(5),
                                Text(
                                    '${context.loc.price}: \$${_cart.cartItemsShow[index].discountPrice}'),
                              ])
                        ]),
                  );
                }),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff193d3d),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.loc.totalPrice,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "\$${_cart.totalSendBuy}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            //CartItemSampLess(),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.loc.paymentType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _cart.isSelectPayPal,
                        onChanged: (value) {
                          ref.read(cartProvider).changSelectPayPal();
                        },
                      ),
                      Gap(10),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xff193d3d).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${AppConstants.SERVER_API_URL}storage/images/stripe.png',
                              ),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Gap(10),
                      Text(
                        "Stripe",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _cart.isSelectVnPay,
                        onChanged: (bool? value) {
                          ref.read(cartProvider).changSelectVnPay();
                        },
                      ),
                      Gap(10),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xff193d3d).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${AppConstants.SERVER_API_URL}storage/images/vnpay.png',
                              ),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Gap(10),
                      Text(
                        "VnPay",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _cart.isSelectDirect,
                        onChanged: (value) {
                          ref.read(cartProvider).changSelectDirect();
                        },
                      ),
                      Gap(10),
                      Text(
                        context.loc.direct,
                        style: TextStyle(
                          fontSize: 14,
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () async {
            // Xử lý sự kiện khi nút "Continue" được nhấn
            await ref
                .read(cartProvider.notifier)
                .sendItemBuy(userId.toString());
            if (_cart.isSelectDirect) {
              final OrderModel? order = ref.watch(cartProvider.notifier).order;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderResults(order: order!, isSuccess: true),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: _cart.url),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff193d3d),
            elevation: 8.0,
          ),
          child: Text(context.loc.paynow),
        ),
      ),
    );
  }
}
//import 'package:image/image.dart';

// ignore: camel_case_types

class RoundedIconContainer extends StatelessWidget {
  final IconData icon;
  final String label;

  const RoundedIconContainer(
      {Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
