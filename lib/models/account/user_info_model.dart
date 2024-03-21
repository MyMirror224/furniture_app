import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/typedef/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, dynamic>{
  final UserId userId;
  final String displayName;
  final String email;
  final String? password;
  final List<String?>? address;
  final String userType;
  final String? userImage;
  final String? phoneNumber;
  UserInfoModel({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.password,
    required this.address,
    required this.userType,
    required this.userImage,
    required this.phoneNumber,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName,
            FirebaseFieldName.email: email,
            FirebaseFieldName.password : password,
            FirebaseFieldName.address : address?.where((element) => element != null).toList() ?? [],
            FirebaseFieldName.userType : userType,
            FirebaseFieldName.userImage: userImage,
            FirebaseFieldName.phoneNumber: phoneNumber,
          },
        );
    
    UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.email],
          password: json[FirebaseFieldName.password] ?? "" ,
          address:json[FirebaseFieldName.address].split('@') ?? '' ,
          userType:json[FirebaseFieldName.userType] ,
          userImage: json[FirebaseFieldName.userImage] ?? '',
          phoneNumber: json[FirebaseFieldName.phoneNumber] ?? '',
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email &&
          password == other.password &&
          address == other.address &&
          userType == other.userType &&
          userImage == userImage &&
          phoneNumber == other.phoneNumber;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          displayName,
          email,
          password,
          address,
          userType,
          userImage,
          phoneNumber,
        ],
      );
}