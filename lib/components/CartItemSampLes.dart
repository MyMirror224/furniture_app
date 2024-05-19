import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/cart_model.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemSampLess extends HookConsumerWidget {
  final List<CartItems> items;
  const CartItemSampLess({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          bool isPromote = item.discountPrice != item.price;
          if (items.isEmpty) {
            return const Center(child: Text('No Item in cart'));
          }
          return Container(
            height: height * 0.16,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff193d3d),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      Checkbox(
                        value: item.isSelected,
                        activeColor: const Color(0xff193d3d),
                        onChanged: (bool? value) {
                          ref.read(cartProvider).changSelect(index, value!);
                        },
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${AppConstants.SERVER_API_URL}storage/" +
                                    item.image.toString(),
                              ),
                              fit: BoxFit.fill,
                            )),
                      ),
                    ])
                  ],
                ),
                Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 3.2,
                      height: height * 0.06,
                      child: Text(
                        item.name.toString().substring(item.name!.indexOf(' ')),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Text(
                          ("\$${item.price}"),
                          style: GoogleFonts.roboto(
                            fontSize: isPromote ? 11.0 : 13.0,
                            fontWeight:
                                isPromote ? FontWeight.w400 : FontWeight.bold,
                            decoration: isPromote
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: isPromote ? Colors.grey[600] : Colors.red,
                          ),
                        ),
                        const Gap(10),
                        Opacity(
                          opacity: isPromote ? 1.0 : 0.0,
                          child: Text(
                            ("\$${item.discountPrice}"),
                            style: GoogleFonts.roboto(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(cartProvider.notifier)
                            .delete(userId.toString(), item.id!);
                      },
                      child: Icon(
                        Icons.close,
                        color: Color(0xff193d3d), // Thay đổi màu sắc của Icon
                        size: height * 0.03, // Thay đổi kích thước của Icon
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: IconButton(
                    //     iconSize: 18, // Thay đổi kích thước của Icon
                    //     icon: Icon(
                    //       Icons.close,
                    //       color: Color.fromARGB(
                    //           255, 150, 150, 150), // Thay đổi màu sắc của Icon
                    //     ),
                    //     onPressed: () {
                    //       // Xử lý sự kiện khi nhấn nút X
                    //     },
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff193d3d),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: GestureDetector(
                              onTap: () {
                                ref.read(cartProvider.notifier).changQuantity(
                                    index, -1, userId.toString());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xff193d3d),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: const Icon(
                                  CupertinoIcons.minus,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              item.quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff193d3d),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .changQuantity(index, 1, userId.toString());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xff193d3d),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: const Icon(
                                  CupertinoIcons.plus,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
