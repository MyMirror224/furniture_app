import 'dart:convert';

import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/models/notification/notification.dart';
import 'package:furniture_app/services/constain.dart';
import 'package:http/http.dart' as http;

import '../../../services/shared preferences/sharedPreferences.dart';

Future<List<NotificationModel>> futureGetNotification() async {
  print("hello world");
  var temp;
  await SharedPreferencesObject().futureGetIdCus().then((value) async {
    print("dbidbiudb");
    temp = value;
  });
  http.Response response = await http.post(Uri.parse('${AppConstants.SERVER_API_URL}api/get-noti'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'IDCus': 1}));
  if (response.statusCode == 200) {
    var list = json.decode(response.body);
    var res = <NotificationModel>[];
    for (var i in list) {
      res.add(NotificationModel.fromJson(i));
    }
    return res;
  } else {
    throw Exception('Failed to load Notification');
  }
}
