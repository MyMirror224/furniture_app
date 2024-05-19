import 'package:flutter/foundation.dart';
import 'package:furniture_app/service/http_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LockUserNotifier extends ChangeNotifier {
  bool _isLockUser = false;
  bool get isLockUser => _isLockUser;
  Future<void> checkLock(String uid) async {
    try {
      final reponse = await HttpUtil().post(
        'api/users/checklock',
        queryParameters: {'uid': uid},
      );
      final message = reponse['message'];
      if(message == 'true'){
        _isLockUser= true;
      }
     
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  Future<void> setLock() async {
    try {
      
      _isLockUser=false;
     
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
final lockUserProvider = ChangeNotifierProvider<LockUserNotifier>((ref) {
  return LockUserNotifier();
});
