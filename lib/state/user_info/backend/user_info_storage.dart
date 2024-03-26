
import 'dart:convert';

import 'package:furniture_app/service/http_util.dart';

import 'package:furniture_app/state/user_info/backend/base_respone.dart';
import 'package:furniture_app/state/user_info/models/user.dart';
import 'package:furniture_app/state/user_info/models/user_info_model.dart';



class UserAPI {
    static Future<UserRegisterResponseEntity> createUserInDatabase({
    RegisterRequestEntity? params,
  }) async {
   
    var response = await HttpUtil().post(
      'api/users/create',
      queryParameters: params?.toJson(),
    );
   
    return UserRegisterResponseEntity.fromJson(response); 
  }

   static Future<UserInfoResponseEntity> getProfile(String userId) async {
    var response = await HttpUtil().post(
      'api/users/profile',
      queryParameters: {'uid': userId},
    ); 
    return UserInfoResponseEntity.fromJson(response);
  }
  static Future<UserInfoResponseEntity> updateProfile({
    UserInfoModel? params,
  }) async {
    var response = await HttpUtil().post(
      'api/users/update_profile',
      queryParameters: params?.toJson(),
    );
    return UserInfoResponseEntity.fromJson(response);
  }


}