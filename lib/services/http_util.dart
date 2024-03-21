import 'package:dio/dio.dart';

class HttpUtil {
  late Dio dio;
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: "127.0.0.1:8000",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {}, // headers dùng để gửi thông tin đến server
        contentType: "application/json: charset=utf-8",
        responseType: ResponseType.json);
    dio = Dio(options);
  }
}
