import 'package:flutter/material.dart';
import 'package:furniture_app/model/notify_model.dart';
import 'package:furniture_app/services/logger.dart';
import 'package:furniture_app/state/notify/notify_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifyNotifier extends ChangeNotifier {
  bool isShow = false;
  List<NotificationModel> notifications = [];

  Future<void> changeShow(bool value) async {
    isShow = value;
    notifyListeners();
  }

  // Future<void> setupOneSignal(int userId) async {
  //   await initOneSignal();
  //   registerOneSignalEventListener(
  //     onOpened: onOpened,
  //     onReceivedInForeground: onReceivedInForeground,
  //   );
  //   promptPolicyPrivacy(userId);
  // }

  // void onOpened(OSNotificationOpenedResult result) {
  //   // vLog('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
  //   // vLog(
  //   //     "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}")
  //   // try {
  //   //   final data = result.notification.additionalData;
  //   //   if (data != null) {
  //   //     final chatId = (data['data']['chatId'] as int);
  //   //     final chatBloc = context.read<ChatBloc>();
  //   //     final selectedChat = chatBloc.state.selectedChat;

  //   //     if (chatId != selectedChat?.id) {
  //   //       chatBloc.add(ChatNotificationOpened(chatId));
  //   //       Navigator.of(context).pushNamed(ChatScreen.routeName);
  //   //     }
  //   //   }
  //   //} catch (_) {}
  // }

  // void onReceivedInForeground(OSNotificationReceivedEvent event) {
  //   // vLog(
  //   //     "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
  //   // //final chatBloc = context.read<ChatBloc>();
  //   // try {
  //   //   // final data = event.notification.additionalData;
  //   //   // //final selectedChat = chatBloc.state.selectedChat;
  //   //   // if (selectedChat != null && data != null) {
  //   //   //   vLog(data);
  //   //   //   final chatId = (data['data']['chatId'] as int);

  //   //   //   if (selectedChat.id == chatId) {
  //   //   //     event.complete(null);
  //   //   //     return;
  //   //   //   }
  //   //   }
  //   //   chatBloc.add(const ChatStarted());
  //   //   event.complete(event.notification);

  //   //   vLog(data);
  //   // } catch (_) {
  //   //   event.complete(null);
  //   // }
  // }

  // Future<void> promptPolicyPrivacy(int userId) async {
  //   final oneSignalShared = OneSignal.shared;

  //   bool userProvidedPrivacyConsent =
  //       await oneSignalShared.userProvidedPrivacyConsent();

  //   if (userProvidedPrivacyConsent) {
  //     sendUserTag(userId);
  //   } else {
  //     bool requiresConsent = await oneSignalShared.requiresUserPrivacyConsent();

  //     if (requiresConsent) {
  //       final accepted =
  //           await oneSignalShared.promptUserForPushNotificationPermission();
  //       if (accepted) {
  //         await oneSignalShared.consentGranted(true);
  //         sendUserTag(userId);
  //       }
  //     } else {
  //       sendUserTag(userId);
  //     }
  //   }
  // }
  Future<void> fetchNotification(String userId) async {
    try {
      final notify = await NotifyApi.getNotify(userId);
      notifications = notify;
      notifyListeners();
    } catch (_) {
      eLog(_);
    }
  }

  Future<void> updateNotification(int id, String userId, int type) async {
    try {
      final notify = await NotifyApi.update(id, userId, type);
      notifications = notify;
      notifyListeners();
    } catch (_) {
      eLog(_);
    }
  }

  void addNewNotification(NotificationModel notify) {
    notifications.insert(0, notify);
    notifyListeners();
  }
}

final notifyProvider = ChangeNotifierProvider((ref) => NotifyNotifier());
