import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/global.dart';
import 'package:furniture_app/model/user_info_model.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/service/http_util.dart';
import 'package:furniture_app/state/user_info/backend/user_info_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UpdateInfoController extends ChangeNotifier {
  bool isLoading = false;
  String? message = '';

  void setLoading(bool value) {
    isLoading = value;
  }

  Future<File> getImage() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    File file = File(image!.path);
//print(‘Image picked’);
    return file;
  }

  Future<void> updateAvatar({required File empFace, String? uid}) async {
    const url = '${AppConstants.SERVER_API_URL}api/users/update_avatar';
    var formData = FormData.fromMap({'uid': uid, 'avatar': empFace});

    final response = await HttpUtil().postForm(
      url,
      data: formData,
    );

    String message = response['message'];

    if (message == 'Avatar updated successfully') {
      final data = await UserAPI.getProfile(userIdProvider.toString());
      await Global.storageService
          .setProfile(userIdProvider.toString(), data.data as UserInfoModel);
    }
    
  }

  Future<void> updateInfo(
      String uid,
      String? name,
      String? avatar,
      String? phone,
      String? address,
      String? oldPassword,
      String? password) async {
    isLoading = true;
    final response = await UserAPI.updateProfile(
      params: UserInfoModel(
        uid: uid,
        name: name,
        avatar: avatar,
        address: address,
        phone_number: phone,
        email: null,
        oldPassword: oldPassword,
        password: password,
      ),
    );
    if (oldPassword != null && password != null) {
      message = response;
    }
    if (message != 'Old password is incorrect') {
      final respone1 = await UserAPI.getProfile(uid.toString());
      await Global.storageService
          .setProfile(uid.toString(), respone1.data as UserInfoModel);
    }


    isLoading = false;
    notifyListeners();
  }
}

final updateInfoProvider =
    ChangeNotifierProvider((ref) => UpdateInfoController());
