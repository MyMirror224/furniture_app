import 'package:flutter/material.dart';
import 'package:furniture_app/global.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class inforNotifier extends ChangeNotifier {
  String _detail_information = '0';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  String get detail_information => _detail_information;

  Future<void> changeInfoName(String Name) async {
    nameController.text = Name;
    notifyListeners();
  }

  Future<void> changeInfoPhone(String Phone) async {
    phoneController.text = Phone;
    notifyListeners();
  }

  Future<void> changeInfoAddress(String Address) async {
    addressController.text = Address;
    notifyListeners();
  }

  Future<void> setDetailInformation(String uid) async {
    final sub = Global.storageService.getProfile(uid.toString());
    nameController.text = sub!.name!;
    phoneController.text = sub.phone_number!;
    addressController.text = sub.address!;
    notifyListeners();
  }

  void updateDetailInformation(String newDetailInformation) {
    _detail_information = newDetailInformation;
    notifyListeners();
  }
}

final InforUserNotifer = ChangeNotifierProvider((ref) => inforNotifier());
