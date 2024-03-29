import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_app/constant/firebase_field_collection.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/state/user_info/models/user_info_payload.dart';
import 'package:furniture_app/typedef/user_id.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  
  Future<bool> createUserInfo({
    required UserId userId,
    required String displayName,
    required String email,
    required String? password,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      
      if (userInfo.docs.isNotEmpty) {
        return false;
      }
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email ,
        password: password?? "",
        address:  const [],
        userType: "customer",
        userImage: "",
        phoneNumber: "",
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
  Future<bool> updateUserInfo(
     UserId userId,
     String displayName,
     String email,
     String? password,
     List<String?>? address,
     String userType,
     String? userImage,
     String? phoneNumber,
  ) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      
      if (userInfo.docs.isEmpty) {
        return false;
      }
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email ,
        password: password,
        address: address,
        userType: userType,
        userImage: userImage,
        phoneNumber: phoneNumber,
      );

      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .doc(userInfo.docs.first.id)
          .update(payload);
      return true;
      
    } catch (_) {
      return false;
    }
  }
}
