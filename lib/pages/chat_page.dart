import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/services/laravel_echo.dart';
import 'package:furniture_app/state/chat/chat_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late List<ChatMessage> messages;
  late ChatUser users;
  @override
  void initState() {
    super.initState();
  }

  // void listenChatChannel(ChatEntity chat) {
  //   // LaravelEcho.instance.private('chat.${chat.id}').listen('.message.sent',
  //   //     (e) {
  //   //   if (e is PusherEvent) {
  //   //     if (e.data != null) {
  //   //       vLog(jsonDecode(e.data!));
  //   //       _handleNewMessage(jsonDecode(e.data!));
  //   //     }
  //   //   }
  //   // }).error((err) {
  //   //   eLog(err);
  //   // });
  // }

  // void leaveChatChannel(ChatEntity chat) {
  //   // try {
  //   //   LaravelEcho.instance.leave('chat.${chat.id}');
  //   // } catch (err) {
  //   //   eLog(err);
  //   // }
  // }

  // void _handleNewMessage(Map<String, dynamic> data) {
  //   // final chatBloc = context.read<ChatBloc>();
  //   // final selectedChat = chatBloc.state.selectedChat!;
  //   // if (selectedChat.id == data['chat_id']) {
  //   //   final chatMessage = ChatMessageEntity.fromJson(data['message']);
  //   //   chatBloc.add(AddNewMessage(chatMessage));
  //   // }
  // }

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
    );
  }
}
