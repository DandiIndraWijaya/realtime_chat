import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/auth/authPage.dart';
import 'package:realtime_chat/ui/pages/chat/chatPage.dart';
import 'package:realtime_chat/ui/pages/contacts/contactsPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: const AuthPage().routeName,
      getPages: [
        GetPage(name: const AuthPage().routeName, page: () => const AuthPage()),
        GetPage(
            name: const ContactsPage().routeName,
            page: () => const ContactsPage()),
        GetPage(name: ChatPage().routName, page: () => ChatPage())
      ],
    );
  }
}
