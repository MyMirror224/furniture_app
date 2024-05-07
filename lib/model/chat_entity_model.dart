import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:furniture_app/model/user_info_model.dart';

class ChatMessageEntity {
  final int id;
  final String chatId;
  final int userId;
  final String message;
  final String createdAt;
  final String updatedAt;
  final UserInfoModel user;

  ChatMessageEntity({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      id: json['id'],
      chatId: json['chat_id'],
      userId: json['user_id'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: UserInfoModel.fromJson(json['user']),
    );
  }
  ChatMessage get toChatMessage {
    return ChatMessage(
      user:  user.toChatUser,
      text:  message,
      createdAt:  DateTime.parse(createdAt),
    );
  }
} 
