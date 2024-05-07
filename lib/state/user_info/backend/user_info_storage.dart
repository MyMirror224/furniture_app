import 'package:furniture_app/model/user_info_model.dart';
import 'package:furniture_app/model/user_respone.dart';
import 'package:furniture_app/service/http_util.dart';

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

  static Future<String> updateProfile({
    UserInfoModel? params,
  }) async {
    var response = await HttpUtil().post(
      'api/users/update_profile',
      queryParameters: params?.toJson(),
    );
    return response['message'];
  }
}
