import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/helpers/user_helper.dart';
import 'package:realtime_chat/models/chat_message_model.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/chat_service.dart';

class ChatPageController extends GetxController {
  UserModel? loggedInUser;
  String? chatUid;
  TextEditingController typedMessage = TextEditingController();

  @override
  void onInit() {
    getLoggedInUser();
    super.onInit();
  }

  void getLoggedInUser() async {
    loggedInUser = await UserHelper().getSignedUser();
    update();
  }

  void sendMessage(String chatUid) {
    if (typedMessage.text == '' || chatUid == '') return;

    ChatService().createChatMessage(
      chatUid,
      typedMessage.text,
      '22/12/2022',
      '14:10',
      loggedInUser!.id.toString(),
    );
    typedMessage.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
    update();
  }
}
