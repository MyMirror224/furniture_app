import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/components/information_user_field.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';

import 'package:furniture_app/state/user_info/controller_update_info.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    final password = user.hasValue ? user.value!.password.toString() : '';
    final TextEditingController oldPassword = TextEditingController();
    final TextEditingController newPassword = TextEditingController();
    final TextEditingController confirmPassword = TextEditingController();
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(30),
          const Row(children: [
            Gap(20),
            ButtonBackIos(),
          ]),
          const Gap(20),
          InformationFields(
            type: "name",
            text: 'Old Password',
          ),
          InformationFields(
              type: "field", text: 'Old Password', controller: oldPassword),
          InformationFields(type: "name", text: 'New Password'),
          InformationFields(
              type: "field", text: 'New Password', controller: newPassword),
          InformationFields(type: "name", text: 'Confirm Password'),
          InformationFields(
              type: "field",
              text: 'Confirm Password',
              controller: confirmPassword),
          const Gap(20),
          buttonLogin('Change Password', Colors.grey, 200, 50,
              onpressed: () async {
                
            
              if (newPassword.text == confirmPassword.text ) {
                
                await ref.read(updateInfoProvider.notifier).updateInfo(
                      userId.toString(),
                      null,
                      null,
                      null,
                      null,
                      oldPassword.text,
                      newPassword.text,
                    );
                final message = ref.watch(updateInfoProvider).message;
                Fluttertoast.showToast(
                  msg: message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color(0xff193d3d),
                  textColor: Colors.white,
                  fontSize: 20.0,
                );
                if(message != 'Old password is incorrect'){
                  await ref
                    .read(authStateProvider.notifier)
                    .updatePassword(newPassword.text);
                }
                return ref.refresh(userInfoModelProvider(userId.toString()));
              } else {
                Fluttertoast.showToast(
                  msg: "Confirm password is incorrect",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color(0xff193d3d),
                  textColor: Colors.white,
                  fontSize: 20.0,
                );
              }
            
             //ref.read(inforProvider.notifier).changePassword();
          }),
        ],
      ),
    );
  }
}
