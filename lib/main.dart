import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AuthPage().routeName,
      getPages: [
        GetPage(name: AuthPage().routeName, page: () => AuthPage()),
        GetPage(name: ContactsPage().routeName, page: () => ContactsPage()),
        GetPage(name: ChatPage().routName, page: () => ChatPage())
      ],
    );
  }
}
