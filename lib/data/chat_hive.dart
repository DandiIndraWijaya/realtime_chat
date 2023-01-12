import 'package:hive/hive.dart';
import 'package:realtime_chat/models/chat_model.dart';

part 'chat_hive.g.dart';

@HiveType(typeId: 2)
class ChatHive {
  ChatHive(
      {required this.uid,
      required this.members,
      required this.lastMessageSent,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});

  @HiveField(0)
  String uid;

  @HiveField(1)
  List<String> members;

  @HiveField(2)
  String lastMessageSent;

  @HiveField(3)
  bool isDeleted;

  @HiveField(4)
  int createdAt;

  @HiveField(5)
  int updatedAt;
}
