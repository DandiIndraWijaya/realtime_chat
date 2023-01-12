import 'package:hive/hive.dart';
import 'package:realtime_chat/models/chat_model.dart';

part 'chat_hive.g.dart';

@HiveType(typeId: 2)
class ChatHive {
  ChatHive({required this.uid, required this.chatList});

  @HiveField(0)
  String uid;

  @HiveField(1)
  List<Chat> chatList;
}
