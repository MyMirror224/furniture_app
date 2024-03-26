import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/global.dart';
import 'package:furniture_app/pages/login_page.dart';
import 'package:furniture_app/state/user_info/backend/user_info_storage.dart';

import 'package:furniture_app/state/user_info/models/user_info_model.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateInfoController extends ChangeNotifier {
  bool isLoading = false;
  


  void setLoading(bool value) {
    isLoading = value;
  }

  Future<bool> updateAvatar(
      {required File empFace, required String empCode}) async {
    final url =
        'My API URL';
    try {
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(empFace.path, filename: empCode),
      });
      final response = await Dio().post(
        url,
        data: formData,
      );
      if (response.statusCode == 200) {
        var map = response.data as Map;
        print('success');
        if (map['status'] == 'Successfully registered') {
          return true;
        } else {
          return false;
        }
      } else {
        //BotToast is a package for toasts available on pub.dev
    
        return false;
      }
    }  catch (error) {
      
      rethrow;
    } 
  }

  Future<void> updateInfo(String uid, String? name, String? avatar, String? phone,
      String? address,String? password) async {
    isLoading = true;
    await UserAPI.updateProfile(
      params: UserInfoModel(
        uid: uid,
        name: name,
        avatar: avatar,
        address: address,
        phone_number: phone,
        email: null,
        password: password,
      ),
    );
    final respone=  await UserAPI.getProfile(uid.toString());
    await Global.storageService.setProfile(uid.toString(), respone.data as UserInfoModel);
    isLoading = false;
    notifyListeners();
  }
}

final updateInfoProvider =
    ChangeNotifierProvider((ref) => UpdateInfoController());
