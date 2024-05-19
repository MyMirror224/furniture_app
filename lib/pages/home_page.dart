import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture_app/components/grip_view_search.dart';
import 'package:furniture_app/components/notify_view.dart';
import 'package:furniture_app/components/slide_home_view.dart';
import 'package:furniture_app/components/startupcontainer.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/model/notify_model.dart';
import 'package:furniture_app/pages/cart_page.dart';
import 'package:furniture_app/pages/product_list_page.dart';
import 'package:furniture_app/pages/search%20page/searchPage.dart';
import 'package:furniture_app/pages/user_information/user_information.dart';
import 'package:furniture_app/provider/isLockUser.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/services/laravel_echo.dart';
import 'package:furniture_app/services/logger.dart';
import 'package:furniture_app/state/category/categogies_provider.dart';
import 'package:furniture_app/state/notify/notify_provider.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int index = 2;

  void listenChatChannel() {
    final userId = ref.watch(userIdProvider);
    print('update-notification${userId.toString()}');
    LaravelEcho.instance
        .channel('update-notification${userId.toString()}')
        .listen(
      '.notification.updated',
      (e) {
        if (e is PusherEvent) {
          print('new noti');
          _handleNewNotification(jsonDecode(e.data!) as Map<String, dynamic>);
        }
      },
    );
  }

  void _handleNewNotification(Map<String, dynamic> data) {
    final notify = NotificationModel.fromJson(data['message']);

    ref.read(notifyProvider.notifier).addNewNotification(notify);
  }

  void leaveChatChannel() {
    final userId = ref.watch(userIdProvider);
    try {
      LaravelEcho.instance.leave('update-notification${userId.toString()}');
    } catch (err) {
      eLog(err);
    }
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(productProvider).newProduct();
      ref.read(productProvider).fetchCategories();
      ref.read(categoryProvider).fetchCategories();
      ref.read(productProvider).fetchProduct();

      ref
          .read(notifyProvider)
          .fetchNotification(ref.watch(userIdProvider).toString());
      ref
          .read(lockUserProvider)
          .checkLock(ref.watch(userIdProvider).toString());
    });
    // WidgetsBinding.instance.addPostFrameCallback((_)  {

    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvi = ref.watch(searchProvider);
    final itemProducts = ref.watch(productProvider).products;
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    final avatar = user.hasValue
        ? user.value!.avatar.toString()
        : "storage/avatars/default.png";
    String longText = user.hasValue ? user.value!.name.toString() : "User";
    final imageUrl = AppConstants.SERVER_API_URL + avatar;
    final catelogiesProvider = ref.watch(categoryProvider).categories;
    bool isShownotify = ref.watch(notifyProvider).isShow;
    final listNotify = ref.watch(notifyProvider).notifications;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final appThemeState = ref.watch(themeNotifierProvider);
    return KeyboardDismisser(
      child: StartUpContainer(
        onInit: () {
          LaravelEcho.init(token: ref.watch(userIdProvider).toString());

          listenChatChannel();
        },
        onDisposed: () {
          leaveChatChannel();
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //bỏ ni test
                      Container(
                        height: height * 0.08,
                        margin: EdgeInsets.only(
                            top: .0,
                            bottom: 15.0,
                            left: width * 0.06,
                            right: width * 0.06),
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.03),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserInformation()));
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            imageUrl,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      // longText.length > 15
                                      //     ? "Hi, "
                                      //         "...${longText.substring(9, longText.length)}"
                                      //     : "Hi, $longText",
                                      // with vn language
                                      longText.length > 15
                                          ? "${context.loc.hi}...${longText.substring(4, longText.length)}"
                                          : "${context.loc.hi}$longText",
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButtonCircle(
                                    icon: Icons.notifications,
                                    onTap: () {
                                      ref
                                          .read(notifyProvider)
                                          .changeShow(!isShownotify);
                                    },
                                  ),
                                  const Gap(5),
                                  IconButtonCircle(
                                    icon: Icons.shopping_cart,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CartPage(userId!.toString()),
                                          ));
                                    },
                                  ),
                                  const Gap(5),
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
                          controller: searchProvi.controllerTextField,
                          onChanged: (v) {
                            //request to get autocomplete searching value
                            //check to can click to clear or not
                            bool canClearTemp;
                            if (v.isNotEmpty) {
                              canClearTemp = true;
                            } else {
                              canClearTemp = false;
                            }
                            if (searchProvi.canClear != canClearTemp) {
                              searchProvi.canClean();
                            }
                          },
                          onSubmitted: (v) async {
                            searchProvi.saveSearchingHistory(v);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 5),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: null,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              color: Colors.black87,
                              onPressed: () {
                                if (searchProvi
                                    .controllerTextField.text.isNotEmpty) {
                                  searchProvi.saveSearchingHistory(
                                      searchProvi.controllerTextField.text);
                                  ref
                                      .read(productProvider.notifier)
                                      .setHeight(400);
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListPage(0,
                                        searchProvi.controllerTextField.text),
                                  ),
                                );
                              },
                            ),
                            border: InputBorder.none,
                            hintText: context.loc.search,
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TitleOfPage(name: context.loc.categories),
                        ],
                      ),
                      const Gap(20),
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 15.0, left: 20, right: 20),
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductListPage(
                                          catelogiesProvider[index]!
                                              .cateloryId!,
                                          null),
                                    ),
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    margin: const EdgeInsets.only(right: 10.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF93B1A6),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                        child: Text(catelogiesProvider[index]!
                                            .cateloryName
                                            .toString()))),
                              );
                            },
                            itemCount: catelogiesProvider.length),
                      ),
                      SlideHome(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleOfPage(name: context.loc.popular),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductListPage(0, null),
                                ),
                              );
                            },
                            child: Text(
                              'See All...',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: appThemeState == ThemeMode.dark
                                    ? Colors.white
                                    : Color(0xFF183D3D),
                              ),
                            ),
                          )
                        ],
                      ),
                      GripViewSearch(
                        productsStream: itemProducts,
                        length: 8,
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: 70,
              //   right: 20,
              //   child: Container(
              //     height: 600,
              //     width: 320,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Color(0xFF93B1A6),
              //     ),
              //     child: ListView.builder(
              //       itemCount: 3,
              //       itemBuilder: (context, index) {
              //         return const Text(
              //           "Data",
              //           style: TextStyle(color: Colors.white, fontSize: 30),
              //         );
              //       },
              //     ),
              //     //ListView
              //   ),
              // ),
              if (isShownotify)
                AnimatedPositioned(
                  duration:
                      Duration(milliseconds: 500), // Thời gian chuyển động
                  curve: Curves.easeInOut, // Hiệu ứng chuyển động
                  top: width * 0.1,
                  right: width * 0.21,
                  child: Transform.rotate(
                    angle: 6.28,
                    child: ClipPath(
                      clipper: TriangleClipper(),
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Color(0xFF93B1A6),
                      ),
                    ),
                  ),
                ),
              if (isShownotify)
                AnimatedPositioned(
                  duration: Duration(milliseconds: 5000),
                  curve: Curves.easeInOut,
                  top: width * 0.16,
                  right: width * 0.1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF93B1A6),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF93B1A6),
                            spreadRadius: 8,
                          )
                        ]),
                    child: NotifyView(lists: listNotify),
                  ),
                ),

              // if (isShownotify)
              //   Positioned(
              //     top: 55, // Điều chỉnh vị trí top
              //     right: 70, // Điều chỉnh vị trí right
              //     child: Transform.rotate(
              //       angle: 6.28, // Xoay 90 độ theo chiều kim đồng hồ
              //       child: ClipPath(
              //         clipper:
              //             TriangleClipper(), // Sử dụng custom clipper để tạo hình tam giác
              //         child: Container(
              //           width: 20, // Điều chỉnh chiều rộng của tam giác
              //           height: 20, // Điều chỉnh chiều cao của tam giác
              //           color: Color(0xFF93B1A6), // Màu sắc của tam giác
              //         ),
              //       ),
              //     ),
              //   ),
              // if (isShownotify)
              //   Positioned(
              //     top: 70,
              //     right: 20,
              //     child: Container(
              //       height: 600,
              //       width: 320,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Color(0xFF93B1A6),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Color(0xFF93B1A6),
              //               spreadRadius: 8,
              //             )
              //           ]),
              //       child: NotifyView(),
              //       //ListView
              //     ),
              //   ),
            ]),
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
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.08,
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
            size: width * 0.06,
            // Điều chỉnh kích thước của Icon theo mong muốn
            color: color, // Đặt màu cho Icon
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(
        size.width / 2, 0); // Di chuyển đến điểm đầu tiên (đỉnh tam giác)
    path.lineTo(0, size.height); // Vẽ đường từ đỉnh đến góc dưới bên trái
    path.lineTo(size.width,
        size.height); // Vẽ đường từ góc dưới bên trái đến góc dưới bên phải
    path.close(); // Đóng đường dẫn

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
