import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constant/appconstant.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/user_info/user_info_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late List<ChatMessage> messages;
  late ChatUser users;
  @override
  void initState() {
    super.initState();
    users = ChatUser(
      id: '1',
      firstName: 'Charles',
      lastName: 'Leclerc',
    );
    messages = <ChatMessage>[
      ChatMessage(
        text: 'Hey!',
        user: users,
        createdAt: DateTime.now(),
      ),
    ];
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
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: DashChat(
              currentUser: ChatUser(
          id: userId!.toString(),
          firstName: userName,
          profileImage: avatarPath,
              ),
              onSend: (ChatMessage message) {
          setState(() {
            messages.insert(0, message);
          });
              },
              messages: messages,
            ),
        ));
  }
}
