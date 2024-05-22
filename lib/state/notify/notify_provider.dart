import 'package:flutter/material.dart';
import 'package:furniture_app/model/notify_model.dart';
import 'package:furniture_app/services/logger.dart';
import 'package:furniture_app/state/notify/notify_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifyNotifier extends ChangeNotifier {
  bool isShow = false;
  List<NotificationModel> notifications = [];
  bool get isRead => _isRead;
  bool _isRead = false;

  Future<void> changeShow(bool value) async {
    isShow = value;
    notifyListeners();
  }

  Future<void> checkIsread() async {
    _isRead = false;
    notifications.forEach((element) {
      if (element.isread == 0) {
        _isRead = true;
        return;
      }
    });

    notifyListeners();
  }

  // }
  Future<void> fetchNotification(String userId) async {
    try {
      final notify = await NotifyApi.getNotify(userId);

      notifications = notify;
      checkIsread();
      notifyListeners();
    } catch (_) {
      eLog(_);
    }
  }

  Future<void> updateNotification(int id, String userId, int type) async {
    try {
      final notify = await NotifyApi.update(id, userId, type);
      notifications = notify;
      checkIsread();
      notifyListeners();
    } catch (_) {
      eLog(_);
    }
  }

  void addNewNotification(NotificationModel notify) {
    notifications.insert(0, notify);
    _isRead = true;
    notifyListeners();
  }
}

final notifyProvider = ChangeNotifierProvider((ref) => NotifyNotifier());
