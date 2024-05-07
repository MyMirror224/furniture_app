



import 'package:dash_chat_2/dash_chat_2.dart';

class UserInfoModel  {
  
  String? name;
  String? email;
  String? avatar;
  String? uid;
  String? user_type;
  String? address;
  String? phone_number;
  String? password;
  String? oldPassword;

  UserInfoModel({
    this.name,
    this.email,
    this.avatar,
    this.user_type,
    this.address,
    this.oldPassword,
    this.phone_number,
    this.uid,
    this.password,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      name: json['name'],
      avatar: json["avatar"],
      oldPassword: json["old_password"] ?? "",
      uid: json["uid"],
      email : json["email"],
      user_type: json["user_type"] ,
      address: json["address"] ,
      phone_number: json["phone_number"] ,
      password:   json["password"] ?? "",
    );
  }
  
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "avatar": avatar,
        "old_password": oldPassword,
        "user_type": user_type,
        "address": address,
        "phone_number": phone_number,
        "password": password,
      };
   

  ChatUser get toChatUser {
    return ChatUser(
      id: uid.toString(),
      firstName: name,
    );
  } 
}      
      

  

