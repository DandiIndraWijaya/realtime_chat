import 'package:hive/hive.dart';
import 'package:realtime_chat/models/chat_message_model.dart';

part 'chat_message_hive.g.dart';

@HiveType(typeId: 1)
class ChatMessageHive {
  ChatMessageHive(
      {required this.chatUid,
      required this.message,
      required this.messageDate,
      required this.messageTime,
      required this.sentBy,
      required this.isDeleted,
      required this.timestamp});

  @HiveField(0)
  String chatUid;

  @HiveField(1)
  String message;

  @HiveField(2)
  String messageDate;

  @HiveField(3)
  String messageTime;

  @HiveField(4)
  String sentBy;

  @HiveField(5)
  int timestamp;

  @HiveField(6)
  bool isDeleted;
}
