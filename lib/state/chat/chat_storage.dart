import 'package:dio/dio.dart';
import 'package:furniture_app/model/chat_entity_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ChatApi {
  static Future<ChatMessageEntity?> createChatMessage(
    String chatID,
    String message,
    String socketId,
  ) async {
    final response = await HttpUtil().post(
      'api/chat/create',
      queryParameters: {
        'chat_id': chatID,
        'message': message,
      },
      options: Options(
        headers: {
          'X-Socket-ID': socketId,
        },
      ),
    );

    return ChatMessageEntity?.fromJson(
      response.data,
    );
  }

  Future<List<ChatMessageEntity>> getChatMessages({
    required int chatId,
    required int page,
  }) async {
    final response = await HttpUtil().get(
      'api/chat/show',
      queryParameters: {
        'page': page,
        'chat_id': chatId,
      },
    );
    var productJson = response['data'];
    final List<ChatMessageEntity> messages = List<ChatMessageEntity>.from(
        productJson.map((x) => ChatMessageEntity.fromJson(x)));
    return messages;
  }
}
