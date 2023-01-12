import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realtime_chat/data/chat_hive.dart';
import 'package:realtime_chat/ui/pages/add_contact/add_contact_page.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:realtime_chat/data/chat_message_hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await DbService().init();

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
        GetPage(name: ChatPage().routName, page: () => ChatPage()),
        GetPage(name: AddContactPage().routeName, page: () => AddContactPage())
      ],
    );
  }
}

class DbService {
  init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ChatMessageHiveAdapter());
    Hive.registerAdapter(ChatHiveAdapter());

    await Hive.openBox('chat_message');
  }
}
