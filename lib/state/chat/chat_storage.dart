import 'package:dio/dio.dart';
import 'package:furniture_app/model/chat_entity_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ChatApi {
  static Future<void> createChatMessage(
    String chatID,
    String message,
    String socketId, 
  ) async {
    final response = await HttpUtil().post(
      'api/message/store',
      queryParameters: {
        'room_id': chatID,
        'uidsender': chatID,
        'message': message,
      },
      options: Options(
        headers: {
          'X-Socket-ID': socketId,
        },
      ),
    );


    
  }

  Future<List<ChatMessageEntity>> getChatMessages({
    required String chatId,
    required int page,
  }) async {
    final response = await HttpUtil().get(
      'api/message/show',
      queryParameters: {
        'page': page,
        'room_id': chatId,
      },
    );
    var productJson = response['data'];
    final List<ChatMessageEntity> messages = List<ChatMessageEntity>.from(
        productJson.map((x) => ChatMessageEntity.fromJson(x)));
    return messages;
  }
}
