import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/pages/cart_page.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/category/categogies_provider.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).setProductsForCateloryId();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);
    final catelogiesProvider = ref.watch(categoryProvider).categories;
    final Map<String, List<ProductModel?>> products =
        ref.watch(productProvider).productsForCateloryId;
    final String Function(int cateId) productsCate =
        ref.watch(productProvider).getCategoryById;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories",
                        style: GoogleFonts.roboto(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        )),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xFF183D3D),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CartPage(userId!.toString()),
                              ));
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: products.entries.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(products.entries.length);
                    final product = products.entries.toList()[index];

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product.key,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             DetailCategoryPage(cateId)));
                                },
                                child: const Text(
                                  "View all",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          SizedBox(
                            height: 200,
                            // Điều chỉnh chiều cao phù hợp
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product.value.length,
                              itemBuilder: (context, index) {
                                final item = product.value[index];
                                print(item);

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailPage(item)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            height: 130,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "${AppConstants.SERVER_API_URL}storage/${item!.image!.first}",
                                                  ),
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                        ),
                                        const Gap(10),
                                        Container(
                                          width: 120,
                                          child: Center(
                                            child: Text(
                                              item.productName!.substring(item
                                                  .productName!
                                                  .indexOf(' ')),
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              maxLines: 3,
                                            ),
                                          ),
                                        ),
                                        const Gap(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${item!.price}\$',
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
