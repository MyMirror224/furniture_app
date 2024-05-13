import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/components/information_user_field.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/helper/image_picker_helper.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:furniture_app/pages/user_information/change_password.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/user_info/controller_update_info.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class UserInformation extends ConsumerStatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserInformationState();
}

class _UserInformationState extends ConsumerState<UserInformation> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));

    String userName = user.hasValue ? user.value!.name.toString() : "User";
    String avatar = user.hasValue
        ? user.value!.avatar.toString()
        : 'storage/avatars/default.png';
    String avatarPath = '${AppConstants.SERVER_API_URL}$avatar';
    String phoneNumber =
        user.hasValue ? user.value!.phone_number.toString() : '';
    String address = user.hasValue ? user.value!.address.toString() : '';
    String emailStream =
        user.hasValue ? user.value!.email.toString() : 'xamaL@example.com';
    String email = emailStream;
    String email1 = email.substring(0, 2);
    String email2 = email.substring(email.indexOf('@'));

    final TextEditingController nameController =
        TextEditingController(text: userName);
    final TextEditingController addressController =
        TextEditingController(text: address);
    final TextEditingController phoneController =
        TextEditingController(text: phoneNumber);
    Size size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Gap(10), ButtonBackIos()]),
                const Gap(20),
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
                const Gap(10),
                Text('$email1****$email2',
                    style: const TextStyle(fontSize: 20)),
                const Gap(10),
                InformationFields(
                  type: "name",
                  text: 'Name',
                ),
                InformationFields(
                  type: "field",
                  text: 'Name',
                  controller: nameController,
                ),
                InformationFields(type: "name", text: 'Phone Number'),
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
                  child: TextFormField(
                    controller: phoneController,
                    // keyboardType: TextInputType.number,
                    onChanged: (value) => phoneNumber = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Your Number",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                InformationFields(type: "name", text: 'Address'),
                InformationFields(
                    type: "field",
                    text: 'Address',
                    controller: addressController),
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
                                builder: (context) => const ChangePassword())),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(20),
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
                              nameController.text,
                              user.value!.avatar.toString(),
                              phoneNumber,
                              addressController.text,
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
            ),
          ),
        ),
      ),
    );
  }
}
