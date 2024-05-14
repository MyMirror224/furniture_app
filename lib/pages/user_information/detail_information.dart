import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/components/information_user_field.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/helper/image_picker_helper.dart';
import 'package:furniture_app/pages/user_information/change_password.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/detail_information_provider.dart';
import 'package:furniture_app/state/user_info/controller_update_info.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeteilInformationPage extends ConsumerStatefulWidget {
  final String uid;
  const DeteilInformationPage(this.uid, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeteilInformationPageState();
}

class _DeteilInformationPageState extends ConsumerState<DeteilInformationPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(InforUserNotifer.notifier).setDetailInformation(widget.uid);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final appThemeState = ref.watch(appThemeStateNotifier);
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    String userName = user.hasValue ? user.value!.name.toString() : "";
    String address = user.hasValue ? user.value!.address.toString() : '';
    String avatarPath = user.hasValue
        ? '${AppConstants.SERVER_API_URL}${user.value!.avatar.toString()}'
        : 'storage/avatars/default.png';

    String emailStream =
        user.hasValue ? user.value!.email.toString() : 'xamaL@example.com';
    String email = emailStream;
    String email1 = email.substring(0, 2);
    String email2 = email.substring(email.indexOf('@'));
    String phoneNumber =
        user.hasValue ? user.value!.phone_number.toString() : '';
    final GlobalKey<FormState> _formKeyadd = GlobalKey<FormState>();
    String nameController = ref.watch(InforUserNotifer).nameController.text;
    String phoneController = ref.watch(InforUserNotifer).phoneController.text;
    String addressController =
        ref.watch(InforUserNotifer).addressController.text;

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
                child: Column(
              children: [
                HomeAppBar(),
                Gap(10),
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(avatarPath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 35,
                              width: 35,
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  final imageFile = await ImagePickerHelper
                                      .pickImageFromGallery();

                                  if (imageFile == null) {
                                    return;
                                  } else {
                                    print(imageFile);
                                    await ref
                                        .read(updateInfoProvider.notifier)
                                        .updateAvatar(
                                          empFace: imageFile,
                                          uid: userId.toString(),
                                        );

                                    print('update avatar success');
                                    return ref.refresh(userInfoModelProvider(
                                        userId.toString()));
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                ),
                Gap(10),
                Text('$email1****$email2',
                    style: const TextStyle(fontSize: 20)),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          controller:
                              ref.watch(InforUserNotifer).nameController,
                          onChanged: (value) {
                            ref
                                .read(InforUserNotifer.notifier)
                                .changeInfoName(value);
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          controller:
                              ref.watch(InforUserNotifer).phoneController,
                          onChanged: (value) {
                            ref
                                .read(InforUserNotifer.notifier)
                                .changeInfoPhone(value);
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.streetAddress,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          controller:
                              ref.watch(InforUserNotifer).addressController,
                          onChanged: (value) {
                            ref
                                .read(InforUserNotifer.notifier)
                                .changeInfoAddress(value);
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
                InformationFields(type: "name", text: "Password"),
                Container(
                  decoration: BoxDecoration(
                    color: appThemeState.isDarkModeEnabled
                        ? const Color(0xff93b1a7)
                        : const Color(0xff93b1a7),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "********",
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ChangePassword())),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonLogin(
                        "Cancel", Colors.black, (size.width * 0.3).toInt(), 50,
                        onpressed: () {
                      Navigator.pop(context);
                    }),
                    const Gap(20),
                    buttonLogin(
                      "Save",
                      Colors.black,
                      (size.width * 0.3).toInt(),
                      50,
                      onpressed: () async {
                        await ref.read(updateInfoProvider.notifier).updateInfo(
                              userId.toString(),
                              nameController,
                              user.value!.avatar.toString(),
                              phoneNumber,
                              addressController,
                              null,
                              null,
                            );
                        Fluttertoast.showToast(
                          msg: "Save Suscess",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xff193d3d),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return ref
                            .refresh(userInfoModelProvider(userId.toString()));
                      },
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
