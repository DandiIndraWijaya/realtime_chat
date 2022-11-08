import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final argumentData = Get.arguments;
  final routName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: const Text('Claire'),
      ),
      body: Center(child: Text("Chat Page ${argumentData['id']}")),
    );
  }
}
