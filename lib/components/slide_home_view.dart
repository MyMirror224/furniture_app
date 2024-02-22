import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideHome extends ConsumerWidget {
  const SlideHome({
    super.key,
    double? viewportFraction,
  }) : viewportFraction = viewportFraction ?? 0.8;
  final double viewportFraction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buiderPageItem(index, ref, viewportFraction);
        },
      ),
    );
  }

  Widget _buiderPageItem(int index, WidgetRef ref, double scaleFactor) {
    double currPageValue = ref.watch(slideHomeProvider).currPageValue;

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
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
          ),
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
