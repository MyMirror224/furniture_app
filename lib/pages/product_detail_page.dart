import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:furniture_app/components/slide_home_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<String> imagePaths = [
  'assets/images/background.jpg',
  'assets/images/background.jpg',
  'assets/images/background.jpg',
];

// ignore: must_be_immutable
class ProductDetailPage extends ConsumerWidget {
  ProductDetailPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController countController =
        TextEditingController(text: '1');
    bool isContainerInvisible = countController.text != '1';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      Icons.arrow_back_ios_sharp,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('4.5',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        Icon(
                          Icons.star,
                          color: Colors.amber[400],
                        ),
                      ],
                    ),
                    const Gap(15),
                    SizedBox(
                      child: Text(
                        "Pearl Beading Fur Textured",
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
                    const Gap(10),
                  ],
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: ListView.builder(
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
                  child:
                      // Your other list view items (if any)
                      ImageSlideshow(
                          height: 260,
                          initialPage: index,
                          autoPlayInterval: 3000,
                          isLoop:
                              true, // Optional: Set autoplay interval // Optional: Customize indicator position
                          onPageChanged: (index) =>
                              print('Page changed to: $index'),
                          children: imageWidgets),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const ExpandableTextWidget(
                    text:
                        '''A chair is a piece of furniture designed for seating one person, providing support and comfort. Typically consisting of a seat, backrest, and often armrests, chairs come in various styles, materials, and sizes to suit different purposes and aesthetic preferences. They are essential in both residential and commercial spaces, serving as functional items for sitting or lounging, as well as decorative elements that contribute to the overall design of a room.
                      
                      Chairs can be crafted from a variety of materials, including wood, metal, plastic, or upholstered with fabric or leather. The design and construction of a chair can range from simple and utilitarian to elaborate and ornate, reflecting cultural influences and design trends. Different types of chairs serve specific purposes, such as dining chairs for meals, office chairs for work, lounge chairs for relaxation, and accent chairs for decorative flair.
                      
                      The ergonomic considerations of a chair, including seat height, back support, and armrest placement, are crucial factors in determining its comfort and functionality. Additionally, chairs may incorporate features like swiveling mechanisms, reclining options, or rocking capabilities to enhance their versatility and user experience.
                      
                      Whether a classic wooden dining chair, a sleek modern office chair, or a plush upholstered armchair, the chair is a ubiquitous and indispensable element of interior design that combines both form and function. 
                      The ergonomic considerations of a chair, including seat height, back support, and armrest placement, are crucial factors in determining its comfort and functionality. Additionally, chairs may incorporate features like swiveling mechanisms, reclining options, or rocking capabilities to enhance their versatility and user experience. '''),
              ),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                child: Row(
                  children: [
                    Text(
                      'Color ',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  1 == index ? Colors.black : Colors.white,
                              child: const CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                    const Gap(30),
                    GestureDetector(
                      onTap: isContainerInvisible ? () {} : null,
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
                      width: 20,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none, // Remove underline
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: countController,
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
                        onTap: () {},
                        child: Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
                color: Color(0xff183D3D),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff183D3D),
                  ),
                  child:  Text(
                    ("\$0.08 "),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amberAccent,
                  ),
                  child: InkWell(
                      onTap: () {},
                      highlightColor: Colors.blue.withOpacity(0.2),
                      child: Row(
                        
                        children: [
                          Text('Add to Card'),
                          Gap(10),
                          Icon(Icons.shopping_bag, color: Colors.white,)
                        ]
                      ) ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> imageWidgets = imagePaths.map((path) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Image.asset(
        path,
        fit: BoxFit.cover,
      ),
    );
  }).toList();
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
              style: GoogleFonts.roboto(fontSize: 12),
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
