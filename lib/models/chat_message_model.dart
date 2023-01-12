import 'package:flutter/cupertino.dart';

class ChatMessage extends ChangeNotifier {
  late String chatUid;
  late String message;
  late String messageDate;
  late String messageTime;
  late String sentBy;
  late int timestamp;
  late bool isDeleted;

  ChatMessage(
      {required this.chatUid,
      required this.message,
      required this.messageDate,
      required this.messageTime,
      required this.sentBy,
      required this.isDeleted,
      required this.timestamp});

  factory ChatMessage.fromRTDB(String chatUid, Map<String, dynamic> data) {
    return ChatMessage(
        chatUid: chatUid,
        message: data['message'],
        messageDate: data['messageDate'],
        messageTime: data['messageTime'],
        sentBy: data['sentBy'],
        isDeleted: data['isDeleted'],
        timestamp: data['timestamp']);
  }
}
