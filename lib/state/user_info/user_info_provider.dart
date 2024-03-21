import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/constant/firebase_field_collection.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/models/account/user_info_model.dart';
import 'package:furniture_app/typedef/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInfoModelProvider =
    StreamProvider.family.autoDispose<UserInfoModel, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<UserInfoModel>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.users,
        )
        .where(
          FirebaseFieldName.userId,
          isEqualTo: userId,
        )
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final json = doc.data();
        final userInfoModel = UserInfoModel.fromJson(
          json,
          userId: userId,
        );
        controller.add(userInfoModel);
      }
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
