import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideHome extends HookConsumerWidget {
  SlideHome({
    super.key,
    double? viewportFraction,
  }) : viewportFraction = viewportFraction ?? 0.8;
  final double viewportFraction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider).newProducts;
    final PageController pageController =
        PageController(viewportFraction: viewportFraction);

    pageController.addListener(() {
      double currPageValue = pageController.page ?? 0.0;
      ref.read(slideHomeProvider.notifier).updateCurrPage(currPageValue);
    });
    return SizedBox(
      height: 230,
      child: PageView.builder(
        controller: pageController,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    products[index]!,
                  ),
                ),
              );
            },
            child: _buiderPageItem(
                index, ref, viewportFraction, products[index]!, context),
          );
        },
      ),
    );
  }

  Widget _buiderPageItem(int index, WidgetRef ref, double scaleFactor,
      ProductModel product, BuildContext context) {
    double currPageValue = ref.watch(slideHomeProvider).currPageValue;
    final width = MediaQuery.of(context).size.width;
    const double height = 220;
    Matrix4 matrix = Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTran = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTran, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currPageValue - index + 1) * (1 - scaleFactor);
      var currTran = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTran, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTran = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTran, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - currScale) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "${AppConstants.SERVER_API_URL}storage/" +
                      product.image!.first.toString(),
                ),
              ),
            ),
          ),
          Positioned(
              right: width * 0.05,
              top: width * 0.05,
              child: Transform.rotate(
                angle: 45 * 3.14 / 180, // Góc xoay (đơn vị radian)
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.redAccent.withOpacity(0.7),
                  ),
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

final slideHomeProvider = ChangeNotifierProvider((ref) {
  return SlideHomeNotifier();
});

class SlideHomeNotifier extends ChangeNotifier {
  double _currPageValue = 0.0;

  double get currPageValue => _currPageValue;

  void updateCurrPage(double newValue) {
    _currPageValue = newValue;
    notifyListeners();
  }
}
