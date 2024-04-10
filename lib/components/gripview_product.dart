import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GripViewProduct extends ConsumerWidget {
  final List<ProductModel?> products;
  final int? length;

  const GripViewProduct({
    Key? key,
    required this.products,
    this.length = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsStream = Stream.fromIterable(products);
    return SizedBox(
      height: 600,
      child:  StreamBuilder<ProductModel?>(
        stream: productsStream ,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.custom(
              gridDelegate: SliverWovenGridDelegate.count(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                pattern: [
                  const WovenGridTile(
                    0.85,
                    crossAxisRatio: 0.95,
                  ),
                  const WovenGridTile(
                    5 / 7,
                    crossAxisRatio: 0.9,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                         snapshot.data!,
                      ),
                    ),
                  ),
                  child: FutureBuilder<Widget>(
              future: buildItemCard(snapshot.data!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          childCount: length,
        ),
      );
    
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  
  Future<Widget> buildItemCard(ProductModel? product) async {
    if (product == null) {
      return const SizedBox.shrink();
    }

    return ItemCard(product);
  }
  
}

class ItemCard extends HookConsumerWidget {
  final ProductModel? product;

  const ItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = "${AppConstants.SERVER_API_URL}storage/${product!.image!.first}"; //AppConstants.SERVER_API_URL + product!.image!.first.toString();
    //print(image);
    final title = product!.productName!.substring(product!.productName!.indexOf(' '));
    return Card(
        child: Column(children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.fill,
              )),
        ),
      ),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(5),
          Flexible(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 3,
            ),
          ),
          Gap(5),
        ],
      ),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${product!.price}\$',
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff183D3D),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        product!,
                      ),
                    ));
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      const Gap(10),
    ]));
  }
}
