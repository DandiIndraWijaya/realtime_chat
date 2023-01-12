import 'package:hive/hive.dart';
import 'package:realtime_chat/models/chat_message_model.dart';

part 'chat_message_hive.g.dart';

@HiveType(typeId: 1)
class ChatMessageHive {
  ChatMessageHive({required this.uid, required this.messageList});

  @HiveField(0)
  String uid;

  @HiveField(1)
  List<ChatMessage> messageList;
}
