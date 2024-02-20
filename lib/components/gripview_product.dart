import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_app/pages/home_page.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class GripViewProduct extends ConsumerWidget {
  final List<ItemProduct> products;
  final int? length;

  const GripViewProduct({
    Key? key,
    required this.products,
    this.length = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 600,
      child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            pattern: [
              const WovenGridTile(
                0.9,
                crossAxisRatio: 0.9,
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
              onTap: () => null,
              child: ItemCard(products[index]),
            ),
            childCount: length,
          )),
    );
  }
}

class ItemCard extends HookConsumerWidget {
  final ItemProduct product;

  const ItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: Column(children: [
      Expanded(
        child: Image.asset(
          product.image,
          fit: BoxFit.cover,
        ),
      ),
      Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            product.name,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 3,
          )
        ],
      ),
      Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${product.price}\$',
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff183D3D),
            ),
            child: GestureDetector(
              
              onTap: () {},
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
