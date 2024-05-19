import 'package:furniture_app/constant/appconstant.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';

class LaravelEcho {
  static LaravelEcho? _singleton;
  static late Echo _echo;
  final String token;

  LaravelEcho._({
    required this.token,
  }) {
    _echo = createLaravelEcho();
  }

  factory LaravelEcho.init({
    required String token,
  }) {
    if (_singleton == null || token != _singleton?.token) {
      _singleton = LaravelEcho._(token: token);
    }

    return _singleton!;
  }

  static Echo get instance => _echo;

  static String get socketId => _echo.socketId() ?? "11111.11111111";
}

class PusherConfig {
  static const appId = "1793464";
  static const key = "4c55c513a0c2bd70d338";
  static const secret = "ef3a9c2724296041b9de";
  static const cluster = "ap1";
  static const hostEndPoint = AppConstants.SettingEndPoint;
  static const hostAuthEndPoint = AppConstants.SERVER_API_URL;
  static const port = 443;
}

PusherClient createPusherClient() {
  PusherOptions options = PusherOptions(
    wsPort: PusherConfig.port,
    encrypted: true,
    host: PusherConfig.hostEndPoint,
    cluster: PusherConfig.cluster,
  );

  PusherClient pusherClient = PusherClient(
    PusherConfig.key,
    options,
    autoConnect: true,
    enableLogging: true,
  );
  pusherClient.connect();
  print("ket noi thanh cong" + pusherClient.getSocketId().toString());
  return pusherClient;
}

Echo createLaravelEcho() {
  return Echo(
    client: createPusherClient(),
    broadcaster: EchoBroadcasterType.Pusher,
  );
}
