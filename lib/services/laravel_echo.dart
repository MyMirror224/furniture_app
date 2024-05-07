import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:laravel_echo/laravel_echo.dart';


class LaravelEcho {
  static LaravelEcho? _singleton;
  static late Echo _echo;
  final String token;

  LaravelEcho._({
    required this.token,
  }) {
    _echo = createLaravelEcho(token);
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
  static const String appKey = '';
  static const String cluster = '';
  static const String authEndpoint = '';
  static const String userAuthEndpoint = '';
  static const String userInfoEndpoint = '';
}

PusherChannelsOptions get options => PusherChannelsOptions.fromCluster(
	scheme: 'wss',
	cluster: 'mt1',
	key: 'a0173cd5499b34d93109',
	host: 'pusher.com',
	shouldSupplyMetadataQueries: true,
	metadata: PusherChannelsOptionsMetadata.byDefault(),
	port: 443,
);

final client = PusherChannelsClient.websocket(
options: options,
connectionErrorHandler: (exception, trace, refresh) {
// here you can handle connection errors.
// refresh callback enables to reconnect the client
refresh();
},
// [OPTIONAL]
// A delay applied when using method .reconnect between
// of these lifecycles PusherChannelsClientLifeCycleState.reconnecting,
// PusherChannelsClientLifeCycleState.pendingConnection
// Basically, the client puts delay between attempts to reconnect
minimumReconnectDelayDuration: const Duration(
seconds: 1,
),
// [OPTIONAL]
// Default timeout of the activity after which the client will ping the server.
// It is needed in case if the server does not provide one.
defaultActivityDuration: const Duration(
seconds: 120,
),
// [OPTIONAL]
// Overrides both defaultActivityDuration and the one that the server provides.
activityDurationOverride: const Duration(
seconds: 120,
),
// [OPTIONAL]
// Timeout duration that is applied while the client is waiting for the pong
// message from the server after pinging it.
waitForPongDuration: const Duration(
seconds: 30,
));

final myPrivateChannel = client.privateChannel(
'private-channel',
authorizationDelegate:
	EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
		authorizationEndpoint: Uri.parse('https://test.pusher.com/pusher/auth'),
		headers: const {},
	),
);

Echo createLaravelEcho(String token ) {
  return Echo(
   
    client: client, 
    broadcaster: EchoBroadcasterType.Pusher,
  );
}