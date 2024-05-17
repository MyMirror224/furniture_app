import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/pages/payment_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
import 'package:furniture_app/state/user_info/controller_update_info.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
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
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    String userName = user.hasValue ? user.value!.name.toString() : "";
    String address = user.hasValue ? user.value!.address.toString() : '';
    String phoneNumber =
        user.hasValue ? user.value!.phone_number.toString() : '';
    final GlobalKey<FormState> _formKeyadd = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: userName);
    final TextEditingController phoneController =
        TextEditingController(text: phoneNumber);
    final TextEditingController addressController =
        TextEditingController(text: address);
    final TextEditingController messageController =
        TextEditingController(text: '');

    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKeyadd,
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
                          const Text(
                            "Cart",
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
                            "Address",
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
                            "Pay",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff193d3d).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Define data",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
                          "Your name",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 8),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: nameController,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              nameController.text = value;
                            },
                            decoration: InputDecoration(
                              focusColor: Colors.blueAccent,
                              enabledBorder: const OutlineInputBorder(
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
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: phoneController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: Colors.black),
                              focusColor: Colors.blueAccent,
                              enabledBorder: const OutlineInputBorder(
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
                          "Delivery address",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Gap(8),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: addressController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.streetAddress,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: Colors.black),
                              focusColor: Colors.blueAccent,
                              enabledBorder: const OutlineInputBorder(
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
                        left: 170, top: 10, right: 15, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            "Set as Default",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff193d3d),
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
                          "Message:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Gap(8), // Khoảng cách giữa Text và TextField
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff193d3d).withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Stack(
                            children: [
                              TextField(
                                controller: messageController,
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff193d3d)),
                                onChanged: (value) {
                                  messageController.text = value;
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  border: InputBorder.none,
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
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () {
              if (_formKeyadd.currentState!.validate()) {
                if (_setAsDefaltNotifier.value) {
                  ref.read(updateInfoProvider.notifier).updateInfo(
                        userId.toString(),
                        nameController.text,
                        null,
                        phoneController.text,
                        addressController.text,
                        null,
                        null,
                      );
                }
                // Xử lý sự kiện khi nút "Continue" được nhấn
                ref.read(cartProvider.notifier).saveInfo(
                    nameController.text,
                    phoneController.text,
                    addressController.text,
                    messageController.text);

                // Chuyển sang trang mới
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff193d3d),
              elevation: 8.0,
            ),
            child: Text('Continue'),
          ),
        ),
      ),
    );
  }
}
