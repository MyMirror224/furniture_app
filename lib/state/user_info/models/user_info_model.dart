


import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/typedef/user_id.dart';


class UserInfoModel  {
  
  String? name;
  String? email;
  String? avatar;
  String? uid;
  String? user_type;
  String? address;
  String? phone_number;
  String? password;

  UserInfoModel({
    this.name,
    this.email,
    this.avatar,
    this.user_type,
    this.address,
    this.phone_number,
    this.uid,
    this.password,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      name: json['name'],
      avatar: json["avatar"],
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
        "user_type": user_type,
        "address": address,
        "phone_number": phone_number,
        "password": password,
      };
   
  
  }      
      

  

