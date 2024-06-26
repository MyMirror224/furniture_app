import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/pages/payment_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:furniture_app/state/user_info/controller_update_info.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

//import 'package:image/image.dart';

class AddressPage extends ConsumerStatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddressPageState();
}

class _AddressPageState extends ConsumerState<AddressPage> {
  final _setAsDefaltNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(cartProvider)
          .setDetailInformation(ref.watch(userIdProvider).toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);

    final width = MediaQuery.of(context).size.width;
    String nameController = ref.watch(cartProvider).nameController.text;
    String phoneController = ref.watch(cartProvider).phoneController.text;
    String addressController = ref.watch(cartProvider).addressController.text;
    String messController = ref.watch(cartProvider).messageController2.text;
    final themeMode = ref.watch(themeNotifierProvider);
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          context.loc.cart,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: const Color(0xff193d3d),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          context.loc.address,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: Color(0xff193d3d).withOpacity(0.5),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff193d3d).withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.payment,
                                size: 15,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          context.loc.pay,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    context.loc.defineInfor,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                //CartItemSampLess(),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.yourName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.pleaseInputName;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: ref.watch(cartProvider).nameController,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            nameController = value;
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.blueAccent,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeMode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Colors
                                      .red), // Màu sắc của đường biên khi có lỗi
                            ),
                          ),
                        ),
                      ), // Khoảng cách giữa Text và TextField
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.phoneNumber,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.pleaseEnterYourPhoneNumber;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: ref.watch(cartProvider).phoneController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.black),
                            focusColor: Colors.blueAccent,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeMode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Colors
                                      .red), // Màu sắc của đường biên khi có lỗi
                            ),
                          ),
                        ),
                      ), // Khoảng cách giữa Text và TextField
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.address,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Gap(8),
                      Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.pleaseInputAddress;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: ref.watch(cartProvider).addressController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (value) {
                            addressController = value;
                          },
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.black),
                            focusColor: Colors.blueAccent,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeMode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Colors
                                      .red), // Màu sắc của đường biên khi có lỗi
                            ),
                          ),
                        ),
                      ), // Khoảng cách giữa Text và TextField
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: width / 2.2, top: 10, right: 15, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          context.loc.setDefault,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _setAsDefaltNotifier,
                        builder: (context, value, child) {
                          return Switch(
                            value: value,
                            onChanged: (newValue) {
                              _setAsDefaltNotifier.value = newValue;
                            },
                            activeColor: Color(0xff193d3d),
                            inactiveTrackColor: Colors.grey,
                            inactiveThumbColor: Colors.white,
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.message,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Gap(8), // Khoảng cách giữa Text và TextField
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Stack(
                          children: [
                            TextField(
                              controller:
                                  ref.watch(cartProvider).messageController2,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              onChanged: (value) {
                                messController = value;
                              },
                              maxLines: null,
                              decoration: InputDecoration(
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusColor: Colors.blueAccent,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themeMode == ThemeMode.light
                                            ? Colors.black
                                            : Colors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors
                                          .red), // Màu sắc của đường biên khi có lỗi
                                ),
                              ),
                            ),
                            // Positioned(
                            //   left: 20,
                            //   top: 15,
                            //   child: Opacity(
                            //     opacity: isTextFieldEmpty
                            //         ? 1.0
                            //         : 0.0, // Điều chỉnh độ mờ của dòng chữ
                            //     child: Text(
                            //       'Note to the sender...',
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () {
              if (nameController != "" &&
                  phoneController != "" &&
                  addressController != "") {
                if (_setAsDefaltNotifier.value) {
                  ref.read(updateInfoProvider.notifier).updateInfo(
                        userId.toString(),
                        nameController,
                        null,
                        phoneController,
                        addressController,
                        null,
                        null,
                      );
                }
                // Xử lý sự kiện khi nút "Continue" được nhấn
                ref.read(cartProvider.notifier).saveInfo(nameController,
                    phoneController, addressController, messController);

                // Chuyển sang trang mới
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              } else {
                print('sai');
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff193d3d),
              elevation: 8.0,
            ),
            child: Text(context.loc.continuee),
          ),
        ),
      ),
    );
  }
}
