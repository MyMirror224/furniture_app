

import 'dart:async';

import 'package:furniture_app/global.dart';
import 'package:furniture_app/state/user_info/models/user_info_model.dart';
import 'package:furniture_app/typedef/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInfoModelProvider =
    StreamProvider.family.autoDispose<UserInfoModel, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<UserInfoModel>();

    final sub = Global.storageService.getProfile(userId.toString());
       
        controller.add(sub as UserInfoModel);

    ref.onDispose(() {
      
      controller.close();
    });

    return controller.stream;
  },
);