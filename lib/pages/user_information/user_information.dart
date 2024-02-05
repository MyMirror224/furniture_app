import 'package:flutter/material.dart';
import 'package:furniture_app/components/information_user_field.dart';
import 'package:furniture_app/components/login_signup/button_login.dart';
import 'package:furniture_app/pages/user_information/change_password.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PersonalInformation extends ConsumerWidget {
  //late DateTime birthDay = DateTime.now();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final no = ref.watch(inforProvider);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Personal Information'),
        ),
        body: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: size.height * 0.1,
                  width: size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const InformationFields(type: "name", text: 'Name'),
              const InformationFields(type: "field", text: 'Full name'),
              const InformationFields(type: "name", text: 'Birth Day'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(DateFormat("dd/MM/yyyy").format(no.birthDay),
                          style: const TextStyle(
                            color: Colors.white54,
                          )),
                    ),
                    IconButton(
                      // nhóoooooo cái này
                      onPressed: () => ref
                          .read(inforProvider.notifier)
                          .ShowDatePicker(context),
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const InformationFields(type: "name", text: 'Email'),
              const InformationFields(type: "field", text: 'Your Email'),
              const InformationFields(type: "name", text: 'Number'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
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
              const InformationFields(type: "name", text: 'Address'),
              Container(
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "example address ",
                        maxLines: 3,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const InformationFields(type: "name", text: "Password"),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
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
                        style: TextStyle(color: Colors.white54),
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
                      "Canned", Colors.black, (size.width * 0.3).toInt(), 50,
                      onpressed: () {}),
                  const Gap(20),
                  buttonLogin(
                      "Save", Colors.black, (size.width * 0.3).toInt(), 50,
                      onpressed: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

final inforProvider = ChangeNotifierProvider((ref) => InforProvider());

class InforProvider extends ChangeNotifier {
  DateTime birthDay = DateTime.now();
  void ShowDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      // if (value != null) {
      //
      // }
      birthDay = value!;
      notifyListeners();
    });
  }
}
