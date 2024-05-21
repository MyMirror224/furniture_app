// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/components/details.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/pages/order_required_page.dart';
import 'package:furniture_app/pages/write_review_page.dart';
import 'package:furniture_app/state/order/order_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//import 'package:furniture_app/widgets/cartbottomnarbar.dart';
//import 'package:image/image.dart';
class InvoicedetailsNotCofirmPage extends ConsumerStatefulWidget {
  final List<ProductInOrder> products;
  final OrderModel order;
  final String is_done;
  const InvoicedetailsNotCofirmPage(
      {super.key,
      required this.order,
      required this.products,
      required this.is_done});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoicedetailsNotCofirmPageState();
}

class _InvoicedetailsNotCofirmPageState
    extends ConsumerState<InvoicedetailsNotCofirmPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(orderProvider)
          .setStringAndButtonShow(widget.is_done, widget.order.type);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final stringButton = ref.watch(orderProvider).stringbutton;
    final reviewText = ref.watch(orderProvider).reviews;
    final themeMode = Theme.of(context).brightness;

    return Scaffold(
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
              const nameInvoicede(),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 145, 145),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.is_done,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Gap(5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'assets/images/thongtindonhang.gif', // Đường dẫn tới hình ảnh của bạn
                        width: 100.0, // Chiều rộng của hình ảnh
                        height: 90.0, // Chiều cao của hình ảnh
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        'assets/images/xegiaohang.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.shipInfor,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          context.loc.express,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        'assets/images/toado.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.inforDelivery,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${context.loc.name}: ${widget.order.name}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            '${context.loc.phone}: ${widget.order.phone_number}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            '${context.loc.address}: ${widget.order.address}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text:
                                '${context.loc.name} : ${widget.order.name}\${context.loc.phone}: ${widget.order.phone_number}\nAddress: ${widget.order.address}'));
                        Fluttertoast.showToast(
                          msg: context.loc.copy,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xff193d3d),
                          fontSize: 16.0,
                        );
                      },
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: context.loc.copy,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: const Color(0xff193d3d),
                            fontSize: 16.0,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    ProductInOrder product = widget.products[index];
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${AppConstants.SERVER_API_URL}storage/" +
                                            product.image.toString(),
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name!.substring(
                                          product.name!.indexOf(' ')),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '${context.loc.quantity}: ${product.quantity.toString()}', // Số lượng sản phẩm
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '\$${product.price.toString()}',
                                    )
                                  ],
                                ),
                              ),
                              widget.is_done == 'Goods delivered'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WriteReviewPage(
                                                        product_id:
                                                            product.product_id!,
                                                        order_id:
                                                            widget.order.id,
                                                        uid:
                                                            widget.order.uid)));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Color(0xff193d3d),
                                        ),
                                        child: Text(reviewText,
                                            style: TextStyle()),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              //   padding: const EdgeInsets.only(
              //       top: 5, right: 10, left: 10, bottom: 15),
              //   // decoration: BoxDecoration(
              //   //   border: Border.all(
              //   //     color: const Color(0xff193d3d),
              //   //     width: 1,
              //   //   ),
              //   //   borderRadius: BorderRadius.circular(7),
              //   // ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [

              //           const SizedBox(height: 5),
              //            Text(
              //             "\$${order.price}",
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 7.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                padding: const EdgeInsets.only(
                    top: 10, right: 25, left: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff193d3d),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons
                          .credit_card, // Icon thẻ Visa (thay thế bằng biểu tượng Visa thực tế)

                      size: 24.0,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.paymentType,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.order.type,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Colors.grey.withOpacity(0.3),
              //         width: 7.0,
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 10,
              //       left: 10,
              //       right: 10,
              //       bottom: 10), // Lề trái, trên, phải, dưới đều là 5px
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       // Expanded(
              //       //   flex: 1,
              //       //   child: Column(
              //       //     crossAxisAlignment: CrossAxisAlignment.start,
              //       //     children: [
              //       //       const Text(
              //       //         'Mã đơn hàng',
              //       //         style: TextStyle(
              //       //           color: Colors.black,
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //       const Gap(3),
              //       //       Text(
              //       //         'thời gian đặt hàng',
              //       //         style: TextStyle(
              //       //           color: Colors.black.withOpacity(0.6),
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //       const Gap(3),
              //       //       Text(
              //       //         'thời gian thanh toán',
              //       //         style: TextStyle(
              //       //           color: Colors.black.withOpacity(0.6),
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //       const Gap(3),
              //       //       Text(
              //       //         'thời gian hoàn thành',
              //       //         style: TextStyle(
              //       //           color: Colors.black.withOpacity(0.6),
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //     ],
              //       //   ),
              //       // ),
              //       // Expanded(
              //       //   flex: 1,
              //       //   child: Column(
              //       //     crossAxisAlignment: CrossAxisAlignment.end,
              //       //     children: [
              //       //       const Text(
              //       //         '387df9237d932',
              //       //         style: TextStyle(
              //       //           color: Colors.black,
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //       const Gap(3),
              //       //       Text(
              //       //         '06/04/2024 03:34',
              //       //         style: TextStyle(
              //       //           color: Colors.black.withOpacity(0.6),
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //       const Gap(3),
              //       //       Text(
              //       //         '07/04/2024 13:08',
              //       //         style: TextStyle(
              //       //           color: Colors.black.withOpacity(0.6),
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //       const Gap(3),
              //       //       Text(
              //       //         '09/04/2024 09:59',
              //       //         style: TextStyle(
              //       //           color: Colors.black.withOpacity(0.6),
              //       //           fontSize: 12.0,
              //       //         ),
              //       //       ),
              //       //     ],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),

              stringButton != ""
                  ? Container(
                      padding: const EdgeInsets.only(
                          top: 5, left: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderCancelPage(
                                              typeSend: stringButton,
                                              order_id: widget.order.id,
                                            )),
                                  );
                                },
                                icon: stringButton == 'Tracking Order'
                                    ? Icon(Icons.track_changes)
                                    : Icon(Icons.cancel),
                                label: stringButton == 'Refund Order'
                                    ? Text(context.loc.cancelOrder)
                                    : Text(stringButton),
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xff193d3d),
                                  backgroundColor:
                                      Colors.white, // Màu văn bản xanh
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color:
                                            Color(0xff193d3d)), // Viền màu xanh
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Bo góc viền
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: file_names
// ignore: file_names

//import 'package:furniture_app/widgets/cartbottomnarbar.dart';
//import 'package:image/image.dart';

