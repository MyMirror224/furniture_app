import 'dart:convert';



import 'package:furniture_app/model/user_info_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setProfile(String key,UserInfoModel data) async {
    return await _pref.setString(key, json.encode(data));
  }
  UserInfoModel? getProfile(String key)  {
    var userInfoJson = _pref.getString(key) ?? '';
    if ( userInfoJson.isNotEmpty) {
    try {
      // Thử phân tích chuỗi JSON thành một đối tượng UserInfo
      return UserInfoModel.fromJson(json.decode(userInfoJson));
    } catch (e) {
      print('Error parsing JSON: $e');
    }
  }
  return null ;
  }

  

  // bool isLoggedIn(){
  //   return _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY)!=null?true:false;
  // }

  // UserProfile getUserProfile(){
  //   var profile = _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY)??"";
  //   var profileJson = jsonDecode(profile);
  //   var userProfile = UserProfile.fromJson(profileJson);
  //   return userProfile;
  // }
}
