import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:furniture_app/components/review_list.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailPage extends ConsumerWidget {
  final ProductModel product;
  const ProductDetailPage(this.product, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final rating = product.rating;
    final quantity = product.quantity;
    final TextEditingController? textController =
        ref.watch(countProvider)._countText;
    final countController = ref.watch(countProvider).count;
    final price = ref.watch(countProvider).totalprice ?? product.price;
    double promotion = double.parse(product.promotion.toString());
    final pricePromote = ref.watch(countProvider).totalPriceasPromotion ??
        product.price! - product.price! * promotion / 100;
    final title =
        product.productName!.substring(product.productName!.indexOf(' '));
    bool isContainerInvisible = countController != 1;
    bool isPromote = pricePromote != price;
    final List<Widget> imageWidgets = ImageWidgets.getImageWidgets(product);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonBackIos(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xFF183D3D),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    SizedBox(
                      child: Text(
                        title,
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(rating.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Icon(
                          Icons.star,
                          color: Colors.amber[400],
                          size: 26,
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Solded: $quantity",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            )),
                      ],
                    ),
                    const Gap(10),
                    Text("Description:",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: ImageSlideshow(
                indicatorBottomPadding: 30,
                height: 240,
                initialPage: 0,
                autoPlayInterval: 3000,
                isLoop:
                    true, // Optional: Set autoplay interval // Optional: Customize indicator position
                onPageChanged: (index) => print('Page changed to: $index'),
                children: imageWidgets),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ExpandableTextWidget(
                  text: product.description!,
                ),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Gap(20),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all Reviews',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
              Gap(10),
            ]),
          ),

//           SliverPadding(

//             padding: const EdgeInsets.only(left: 20, right: 20),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) =>
// ProductReviewList(
//                 reviews: [
//                   Review(
//                     userName: 'John Doe',
//                     userImageUrl:
//                         'http://172.21.0.204:8000/avatar.jpg/storage/avatars/default.png',
//                     rating: 4,
//                     reviewText: 'Great product! Highly recommended.',
//                   ),
//                 ],
//               ),
//               ),
//             )
//           ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
                color: Color(0xff93b1a7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff93b1a7),
                      ),
                      child: Row(
                        children: [
                          Text(
                            ("\$$price"),
                            style: GoogleFonts.roboto(
                              fontSize: isPromote ? 16.0 : 20.0,
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
                              ("\$$pricePromote"),
                              style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )),
                  const Gap(30),
                  Row(children: [
                    GestureDetector(
                      onTap: isContainerInvisible
                          ? () {
                              ref.read(countProvider.notifier).removeCount();
                              ref
                                  .read(countProvider.notifier)
                                  .updateCountText();
                              ref
                                  .read(countProvider.notifier)
                                  .totalPrice(product.price!);
                              ref
                                  .read(countProvider.notifier)
                                  .totalPricehavePromotion(0.2);
                            }
                          : null,
                      child: Opacity(
                        opacity: isContainerInvisible ? 1 : 0.5,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black)),
                          child: const Align(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.minimize_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      width: 35,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none, // Remove underline
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: textController,
                        onChanged: (value) {
                          ref.read(countProvider.notifier).updateCount();
                          ref
                              .read(countProvider.notifier)
                              .totalPrice(product.price!);
                          ref
                              .read(countProvider.notifier)
                              .totalPricehavePromotion(promotion);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const Gap(10),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          ref.read(countProvider.notifier).increment();
                          ref.read(countProvider.notifier).updateCountText();
                          ref
                              .read(countProvider.notifier)
                              .totalPrice(product.price!);
                          ref
                              .read(countProvider.notifier)
                              .totalPricehavePromotion(promotion);
                        },
                        child: const Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    ),
                  ])
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff193d3d),
                    ),
                    child: InkWell(
                        onTap: () {},
                        highlightColor: Colors.blue.withOpacity(0.2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Buy Now',
                                  style:
                                      GoogleFonts.roboto(color: Colors.white)),
                              const Gap(10),
                              const Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                              )
                            ])),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff193d3d),
                    ),
                    child: InkWell(
                        onTap: () {},
                        highlightColor: Colors.blue.withOpacity(0.2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add to Card',
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                              const Gap(10),
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              )
                            ])),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class ImageWidgets {
  static List<Widget> getImageWidgets(ProductModel? product) {
    if (product == null || product.image == null) {
      return [];
    }

    return product.image!.map((path) {
      path = "${AppConstants.SERVER_API_URL}storage/$path";
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Image(
          image: NetworkImage(
            path,
          ),
          fit: BoxFit.fill,
        ),
      );
    }).toList();
  }
}



class ButtonBackIos extends ConsumerWidget {
  final Future<void>? notify;

  const ButtonBackIos({super.key, this.notify});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFF183D3D),
      ),
      child: IconButton(
        onPressed: () async{
          await notify;
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}

class ExpandableTextWidget extends ConsumerWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    String firstHalf = '';
    String secondHalf = '';
    double textHeight = screenHeight / 1.2;
    if (text.length > textHeight) {
      firstHalf = text.substring(0, textHeight.toInt());
      secondHalf = text.substring(textHeight.toInt() + 1, text.length);
    } else {
      firstHalf = text;
      secondHalf = '';
    }

    final providerText = ref.watch(textDescriptionProvider);

    bool hidetext = providerText.hidetext;
    return Column(children: [
      secondHalf.isEmpty
          ? Text(
              text,
              style: GoogleFonts.roboto(fontSize: 14),
            )
          : Column(
              children: [
                Text(
                  hidetext ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: GoogleFonts.roboto(fontSize: 12),
                ),
                InkWell(
                  onTap: () {
                    ref
                        .read(textDescriptionProvider.notifier)
                        .updateHidetext(!hidetext);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Show more',
                        style: GoogleFonts.roboto(
                            fontSize: 12, color: const Color(0xFF183D3D)),
                      ),
                      Icon(
                        hidetext ? Icons.arrow_downward : Icons.arrow_upward,
                        color: const Color(0xFF183D3D),
                      )
                    ],
                  ),
                )
              ],
            ),
    ]);
  }
}

final textDescriptionProvider = ChangeNotifierProvider(
  (ref) => TextDescriptionNotifier(),
);

class TextDescriptionNotifier extends ChangeNotifier {
  bool _hidetext = true;

  bool get hidetext => _hidetext;
  void updateHidetext(bool newValue) {
    _hidetext = newValue;
    notifyListeners();
  }
}

final countProvider = ChangeNotifierProvider(
  (ref) => CountProduct(),
);

class CountProduct extends ChangeNotifier {
  int _count = 1;
  int get count => _count;
  final TextEditingController? _countText = TextEditingController(text: '1');
  TextEditingController get countText => _countText!;
  void updateCountText() {
    _countText?.text = _count.toString();
    notifyListeners();
  }

  void updateCount() {
    try {
      if (_countText?.text == '') {
        _count = 1;
      } else {
        _count = int.parse(_countText!.text);
      }
    } catch (e) {
      _count = 1;
    }
    notifyListeners();
  }

  double? _total;
  double? get totalprice => _total;
  double? _totalasPromotion;
  double? get totalPriceasPromotion => _totalasPromotion;
  void increment() {
    _count++;
    notifyListeners();
  }

  void removeCount() {
    _count--;
    notifyListeners();
  }

  void totalPrice(double price) {
    _total = _count * price;
    notifyListeners();
  }

  void totalPricehavePromotion(double promotion) {
    final x = _total! * promotion / 100;
    _totalasPromotion = (_total! - x);
    notifyListeners();
  }
}
