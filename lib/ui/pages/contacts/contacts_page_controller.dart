import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realtime_chat/data/chat_hive.dart';
import 'package:realtime_chat/data/chat_message_hive.dart';
import 'package:realtime_chat/helpers/chat_messages_sort.dart';
import 'package:realtime_chat/helpers/user_helper.dart';
import 'package:realtime_chat/models/chat_message_model.dart';
import 'package:realtime_chat/models/chat_model.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/services/user_service.dart';
import 'package:realtime_chat/ui/pages/add_contact/add_contact_page.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPageController extends GetxController {
  UserModel? loggedInUser;
  Box<ChatMessageHive> chatMessageHive = Hive.box('chat_message');
  Box<ChatHive> chatHive = Hive.box<ChatHive>('chat');

  List<UserModel> users = [];
  late bool isLoading;

  @override
  void onInit() async {
    isLoading = true;
    getLoggedInUser();

    bool isChatInLocalStorage = await checkChatsInLocalStorage();

    if (!isChatInLocalStorage) {
      downloadAllChatDataToLocalStorage();
    }

    super.onInit();
  }

  void getLoggedInUser() async {
    loggedInUser = await UserHelper().getSignedUser();
    isLoading = false;
    update();
  }

  goToContactPage() async {
    var result = Get.to(AddContactPage());
    print("Result nih bos: " + result.toString());
    if (result == 'success') {
      getLoggedInUser();
    }
  }

  Future<bool> checkChatsInLocalStorage() async {
    chatMessageHive = Hive.box('chat_message');
    chatHive = Hive.box('chat');

    chatMessageHive.toMap();

    if (chatMessageHive.isEmpty || chatHive.isEmpty) {
      return false;
    }
    return true;
  }

  void downloadAllChatDataToLocalStorage() async {
    // Store all chat from realtime database to local
    List<Chat> chatList = await ChatService().getChatList();

    for (Chat chat in chatList) {
      chatHive.add(ChatHive(
          uid: chat.uid,
          members: chat.members,
          isDeleted: chat.isDeleted,
          lastMessageSent: chat.lastMessageSent,
          createdAt: chat.createdAt,
          updatedAt: chat.updatedAt));

      List<ChatMessage> chatMessageList =
          await ChatService().getChatMessageList(chat.uid);

      List<ChatMessage> sortedChatMessageList = runQuickSort(chatMessageList);

      for (ChatMessage chatMessage in sortedChatMessageList) {
        chatMessageHive.add(ChatMessageHive(
            chatUid: chat.uid,
            message: chatMessage.message,
            isDeleted: chatMessage.isDeleted,
            messageDate: chatMessage.messageDate,
            messageTime: chatMessage.messageTime,
            sentBy: chatMessage.sentBy,
            timestamp: chatMessage.timestamp));
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseService().googleSignOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(AuthPage());
  }
}
