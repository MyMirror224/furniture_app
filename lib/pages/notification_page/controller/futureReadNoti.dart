import 'dart:convert';

import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/services/constain.dart';
import 'package:http/http.dart' as http;

Future<bool> futureReadNotification(IdNoti) async {
  http.Response response = await http.post(Uri.parse('${AppConstants.SERVER_API_URL}api/read-noti'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'IDNoti': IdNoti.toString()}));
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to load Notification');
  }
}
