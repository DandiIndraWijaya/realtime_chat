import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ChatMessage extends ChangeNotifier {
  final _db = FirebaseDatabase.instance;
  late String message;
  late String messageDate;
  late String messageTime;
  late String sentBy;
  late int timestamp;
  late bool isDeleted;

  ChatMessage(
      {required this.message,
      required this.messageDate,
      required this.messageTime,
      required this.sentBy,
      required this.isDeleted,
      required this.timestamp});

  factory ChatMessage.fromRTDB(Map<String, dynamic> data) {
    return ChatMessage(
        message: data['message'],
        messageDate: data['messageDate'],
        messageTime: data['messageTime'],
        sentBy: data['sentBy'],
        isDeleted: data['isDeleted'],
        timestamp: data['timestamp']);
  }
}
