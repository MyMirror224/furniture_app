import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/typedef/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, dynamic> {
  final UserId userId;
  final String displayName;
  final String email;
  final String? password;
  final List<dynamic> address;
  final String userType;
  final String? userImage;
  final String? phoneNumber;
  UserInfoPayload({
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
            FirebaseFieldName.password: password??"",
            FirebaseFieldName.address: address.toList() ,
            FirebaseFieldName.userType: userType,
            FirebaseFieldName.userImage: userImage ??"",
            FirebaseFieldName.phoneNumber: phoneNumber??"",
          },
        );
}
