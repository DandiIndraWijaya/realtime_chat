import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  List<UserModel> users = [];
  late bool isLoading;

  @override
  void onInit() async {
    isLoading = true;
    getLoggedInUser();
    checkChatsInLocalStorage();
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

  void checkChatsInLocalStorage() async {
    var chatMessageHive = await Hive.openBox('chat_message');
    var chatHive = await Hive.openBox('chat');
    if (chatMessageHive.isEmpty || chatHive.isEmpty) {
      storeAllChatDataToLocal();
    }
  }

  void storeAllChatDataToLocal() async {
    Box<ChatMessageHive> chatMessageHive =
        await Hive.openBox<ChatMessageHive>('chat_message');
    var chatHive = await Hive.openBox('chat');

    // Store all chat from realtime database to local
    List<Chat> chatList = await ChatService().getChatList();
    for (Chat chat in chatList) {
      chatHive.add({'uid': chat.uid, 'chats': chat});

      List<ChatMessage> chatMessageList =
          await ChatService().getChatMessageList(chat.uid);

      List<ChatMessage> sortedChatMessageList = runQuickSort(chatMessageList);

      chatMessageHive.add(
          ChatMessageHive(uid: chat.uid, messageList: sortedChatMessageList));
    }

    // Store all chat message from realtime database to local

    // ChatService().storeChatMessagesToLocal();
  }

  Future<void> signOut() async {
    await FirebaseService().googleSignOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(AuthPage());
  }
}
