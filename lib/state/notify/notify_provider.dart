import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifyNotifier extends ChangeNotifier {
  bool isShow = false;
  
  Future<void> changeShow(bool value) async {

    isShow = value;
    notifyListeners();
  }
}

final notifyProvider = ChangeNotifierProvider((ref) => NotifyNotifier());