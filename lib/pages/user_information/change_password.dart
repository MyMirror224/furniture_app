import 'package:flutter/material.dart';
import 'package:furniture_app/components/information_user_field.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Change Password',
            style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          const InformationFields(type: "name", text: 'Old Password'),
          const InformationFields(type: "field", text: 'Old Password'),
          const InformationFields(type: "name", text: 'New Password'),
          const InformationFields(type: "field", text: 'New Password'),
          const InformationFields(type: "name", text: 'Confirm Password'),
          const InformationFields(type: "field", text: 'Confirm Password'),
          const Gap(20),
          buttonLogin('Change Password', Colors.grey, 200, 50, onpressed: () {
            // ref.read(inforProvider.notifier).changePassword();
          }),
        ],
      ),
    );
  }
}
