import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_chat/models/chat_message_model.dart';

class ChatMessageStreamPublisher {
  final _database = FirebaseDatabase.instance;

  Stream<List<ChatMessage>> getChatMessageStream(String chatUid) {
    final chatMessageStream = _database
        .ref('/chatMessages')
        .child('/$chatUid')
        .orderByChild('timestamp')
        .onValue;

    final streamToPublish = chatMessageStream.map((event) {
      final chatMessageMap = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final chatMessageList = chatMessageMap.entries.map((element) {
        return ChatMessage.fromRTDB(
            chatUid, Map<String, dynamic>.from(element.value));
      }).toList();
      return chatMessageList;
    });

    return streamToPublish;
  }
}
