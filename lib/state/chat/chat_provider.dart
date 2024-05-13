import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/model/chat_entity_model.dart';
import 'package:furniture_app/services/laravel_echo.dart';
import 'package:furniture_app/state/chat/chat_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatMessageNotifier extends ChangeNotifier {

  List<ChatMessageEntity> _chatList = [];
  
  List<ChatMessageEntity> get chatList => _chatList;
  List<ChatMessage> get uiChatMessages {
    return _chatList.map((e) => e.toChatMessage).toList();
  }

  Future<void> fetchChatMessage(String uid) async {
    try 
    {
      final respone =await ChatApi().getChatMessages(chatId: uid, page: 1);

      _chatList = respone;
      notifyListeners();

    }catch (e) {
      print(e);

    }
  }
  Future<void> createChatMessage(ChatMessage message, String chatId, String socketId,) async {
    try{
      await ChatApi.createChatMessage(chatId,message.text, LaravelEcho.socketId);
      await fetchChatMessage(chatId);
    }catch (e) {
      print(e);
    }
  }

  Future<void> addNewMessage(ChatMessageEntity message) async {
    _chatList.insert(0, message);
    notifyListeners();
  }
}
final chatProvider = ChangeNotifierProvider((ref) => ChatMessageNotifier());