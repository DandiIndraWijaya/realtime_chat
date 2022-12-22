import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_chat/models/chat_message.dart';

class ChatMessageStreamPublisher {
  final _database = FirebaseDatabase.instance;

  Stream<List<ChatMessage>> getChatMessageStream(String chatUid) {
    final chatMessageStream = _database.ref('/chatMessages/$chatUid').onValue;

    final streamToPublish = chatMessageStream.map((event) {
      print(event.snapshot.value.toString());
      final chatMessageMap = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final chatMessageList = chatMessageMap.entries.map((element) {
        return ChatMessage.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return chatMessageList;
    });

    return streamToPublish;
  }
}
