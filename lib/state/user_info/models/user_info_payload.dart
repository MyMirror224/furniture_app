// import 'dart:collection' show MapView;

// import 'package:flutter/foundation.dart' show immutable;
// import 'package:furniture_app/constant/firebase_field_name.dart';
// import 'package:furniture_app/typedef/user_id.dart';

// @immutable
// class UserInfoPayload extends MapView<String, String> {
//   final UserId userId;
//   final String displayName;
//   final String email;
//   final String address;
//   final String userType;
//   final String? userImage;
//   final String male;
//   final  DateTime    birthday;
//   final String? phoneNumber;
//   UserInfoPayload({
//     required this.userId,
//     required this.displayName,
//     required this.email,
//     required this.address,
//     required this.birthday,
//     required this.userType,
//     required this.male,
//     required this.userImage,
//     required this.phoneNumber,
//   }) : super(
//           {
//             DataBaseName.userId: userId,
//             DataBaseName.displayName: displayName,
//             DataBaseName.email: email,
//             DataBaseName.male: male,
//             DataBaseName.birthday: birthday.toIso8601String(),
//             DataBaseName.address: address ,
//             DataBaseName.userType: userType,
//             DataBaseName.userImage: userImage ??"",
//             DataBaseName.phoneNumber: phoneNumber??"",
//           },
//         );
// }
