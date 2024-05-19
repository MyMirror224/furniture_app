import 'package:dash_chat_2/dash_chat_2.dart';


class ChatMessageEntity {
  final int id;
  final String roomId;
  final String uidSender;
  final String uidReceiver;
  final String message;
  final String createdAt;
  final String updatedAt;
  final String name;
  

  ChatMessageEntity({
    required this.id,
    required this.roomId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.uidSender,
    required this.uidReceiver,
    required this.name,
  });
  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      id: json['id'],
      roomId: json['room_id'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      uidSender: json['uidsender'] ?? '1',
      uidReceiver: json['uidreceiver'] ?? "",
      name: 'Supporter',
    );
  }
  ChatMessage get toChatMessage {
    return ChatMessage(
      user:  ChatUser(
        firstName:  name,
        id: uidSender,
      ),
      text:  message,
      createdAt:  DateTime.parse(createdAt),
    );
  }
} 


