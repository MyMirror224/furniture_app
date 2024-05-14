import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/startupcontainer.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/model/chat_entity_model.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/services/laravel_echo.dart';
import 'package:furniture_app/services/logger.dart';
import 'package:furniture_app/state/chat/chat_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String uid;
  const ChatPage(this.uid, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late List<ChatMessage> messages;
  late ChatUser users;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider).fetchChatMessage(widget.uid);
    });
    super.initState();
  }

  void listenChatChannel() {
    final userId = ref.watch(userIdProvider);
    LaravelEcho.instance
        .channel('chat-room.1${userId.toString()}')
        .listen('.message.sent', (e) {
      if (e is PusherEvent) {
        if (e.data != null) {
          _handleNewMessage(jsonDecode(e.data!) as Map<String, dynamic>);
        }
      }
    }).error((err) {
      eLog(err);
    });
  }

  void leaveChatChannel() {
    final userId = ref.watch(userIdProvider);
    try {
      LaravelEcho.instance.leave('chat.${userId.toString()}');
    } catch (err) {
      eLog(err);
    }
  }

  void _handleNewMessage(Map<String, dynamic> data) {
    final chatMessage = ChatMessageEntity.fromJson(data['message']);

    ref
        .read(chatProvider.notifier)
        .addNewMessage(chatMessage as ChatMessageEntity);
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);
    final user = ref.watch(userInfoModelProvider(userId.toString()));
    String userName = user.hasValue ? user.value!.name.toString() : "User";
    String avatar = user.hasValue
        ? user.value!.avatar.toString()
        : 'storage/avatars/default.png';
    String avatarPath = '${AppConstants.SERVER_API_URL}$avatar';
    return KeyboardDismisser(
      child: StartUpContainer(
        onInit: () {
          LaravelEcho.init(token: userId.toString());
          print(LaravelEcho.socketId);
          listenChatChannel();
          //setupOneSignal(authBloc.state.user!.id);
        },
        onDisposed: () {
          leaveChatChannel();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text('Support',
                      style: TextStyle(
                          color: Color(0xff193d3d),
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: DashChat(
                currentUser: ChatUser(
                  id: userId!.toString(),
                  firstName: userName,
                  profileImage: avatarPath,
                ),
                onSend: (ChatMessage message) {
                  print(LaravelEcho.socketId);
                  ref.read(chatProvider.notifier).createChatMessage(
                        message,
                        userId.toString(),
                        LaravelEcho.socketId,
                      );
                },
                messages: ref.watch(chatProvider).uiChatMessages,
              ),
            )),
      ),
    );
  }
}
