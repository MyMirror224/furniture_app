import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/state/user_info/models/user_info_model.dart';

class RegisterRequestEntity {
  String? name;
  String? email;
  String? avatar;
  String? uid;
  String? password;

  RegisterRequestEntity({
    this.name,
    this.email,
    this.avatar,
    this.uid,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "avatar": avatar,
        "uid": uid,
        "password": password,
      };
}
class UserCreateResponseEntity {
  int? code;
  String? msg;
  UserProfile? data;

  UserCreateResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserCreateResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserCreateResponseEntity(
        code: json["code"],
        msg: json["message"],
        data: UserProfile.fromJson(json["user"]),
      );
}

class UserRegisterResponseEntity {
  int? code;
  String? msg;
  UserProfile? data;

  UserRegisterResponseEntity({
    this.code,
    this.msg,
    this.data,
  });
   factory UserRegisterResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterResponseEntity(
        code: json["code"],
        msg: json["message"],
        data: UserProfile.fromJson(json["user"]),
      );
}
//api post response msg
class UserInfoResponseEntity {
  int? code;
  String? msg;
  UserInfoModel? data;

  UserInfoResponseEntity({
    this.code,
    this.msg,
    this.data,
  });


  factory UserInfoResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserInfoResponseEntity(
        code: json["code"],
        msg: json["message"],
        data: UserInfoModel.fromJson(json["user"]),
      );
  
}

// login result
class UserProfile {
  String? name;
  String? email;
  String? avatar;
  String? uid;
  String? user_type;
  String? address;
  String? phone_number;

  UserProfile({
    this.name,
    this.email,
    this.avatar,
    this.user_type,
    this.address,
    this.phone_number,
    this.uid,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json["name"],
      avatar: json["avatar"] ??"",
      uid: json["uid"],
      email : json["email"],
      user_type: json["user_type"] ?? "",
      address: json["address"] ?? "",
      phone_number: json["phone_number"] ?? "",

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

      };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      token: data?['token'],
      name: data?['name'],
      avatar: data?['avatar'],
      description: data?['description'],
      online: data?['online'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}
