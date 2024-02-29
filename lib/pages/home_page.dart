// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:furniture_app/components/gripview_product.dart';
import 'package:furniture_app/components/slide_home_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class HomePage extends ConsumerWidget {
  final TextEditingController searchController = TextEditingController();

  int index = 2;
  HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String longText = "Nhat Minh Tran";
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //bỏ ni test
              Container(
                height: 40,
                margin: const EdgeInsets.only(
                    top: .0, bottom: 15.0, left: 20, right: 20),
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/user.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            longText.length > 15
                                ? "Hi, "
                                    "...${longText.substring(9, longText.length)}"
                                : "Hi, $longText",
                            // with vn language
                            // longText.length > 15
                            // ? "Hi, "
                            //     "...${longText.substring(4, longText.length)}"
                            // : "Hi, $longText",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButtonCircle(
                            icon: Icons.message,
                            onTap: () {},
                          ),
                          const Gap(5),
                          IconButtonCircle(
                            icon: Icons.notifications,
                            onTap: () {},
                          ),
                          const Gap(5),
                          IconButtonCircle(
                            icon: Icons.shopping_cart,
                            onTap: () {},
                          ),
                        ],
                      )
                    ]),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xFF93B1A6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 5),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: null,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black87,
                      onPressed: () {},
                    ),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TitleOfPage(name: "Categories"),
                ],
              ),
              const Gap(20),
              Container(
                margin:
                    const EdgeInsets.only(bottom: 15.0, left: 20, right: 20),
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF93B1A6),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(child: Text(items[index].lable))),
                      );
                    },
                    itemCount: items.length),
              ),
              SlideHome(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleOfPage(name: "Popular"),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All...',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF183D3D),
                      ),
                    ),
                  )
                ],
              ),
              GripViewProduct(
                products: itemProducts,
                length: itemProducts.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleOfPage extends StatelessWidget {
  final String name;
  const TitleOfPage({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        name,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class IconButtonCircle extends ConsumerWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  const IconButtonCircle({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 30,
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      decoration: const BoxDecoration(
        color: Color(0xFF93B1A6),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 22,
            // Điều chỉnh kích thước của Icon theo mong muốn
            color: color, // Đặt màu cho Icon
          ),
        ),
      ),
    );
  }
}

List<ItemData> items = [
  ItemData(lable: 'men'),
  ItemData(lable: 'women'),
  ItemData(lable: 'shoes'),
  ItemData(lable: 'bags'),
  ItemData(lable: 'electronics '),
  ItemData(lable: 'accessories'),
  ItemData(lable: 'home & garden'),
  ItemData(lable: 'kids'),
  ItemData(lable: 'beauty'),
];

class ItemData {
  String lable;
  ItemData({required this.lable});
}

class ItemProduct {
  String image;
  String name;
  String price;
  String description;
  ItemProduct(
      {required this.image,
      required this.name,
      required this.price,
      required this.description});
}

List<ItemProduct> itemProducts = [
  ItemProduct(
    image: 'assets/ui-design/images/abctest.jpg',
    name: 'Sofa',
    price: '200.000',
    description: 'Description',
  ),
  ItemProduct(
    image: 'assets/ui-design/images/abctest.jpg',
    name: 'Sofa',
    price: '200.000',
    description: 'Description',
  ),
  ItemProduct(
    image: 'assets/ui-design/images/abctest.jpg',
    name: 'Sofa',
    price: '200.000',
    description: 'Description',
  ),
  ItemProduct(
    image: 'assets/ui-design/images/abctest.jpg',
    name: 'Sofa',
    price: '200.000',
    description: 'Description',
  ),
  ItemProduct(
    image: 'assets/ui-design/images/abctest.jpg',
    name: 'Sofa',
    price: '200.000',
    description: 'Description',
  ),
  ItemProduct(
    image: 'assets/ui-design/images/abctest.jpg',
    name: 'Sofa',
    price: '200.000',
    description: 'Description',
  )
];
