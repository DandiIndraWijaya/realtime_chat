import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_chat/models/chat_model.dart';

import '../models/chat_message_model.dart';

class ChatService {
  final _db = FirebaseDatabase.instance;

  createChatMessage(String chatUid, String message, String messageDate,
      String messageTime, String sentBy) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DatabaseReference ref = _db.ref("/chatMessages/$chatUid/$timestamp");
    ref.set({
      'message': message,
      'messageDate': messageDate,
      'messageTime': messageTime,
      'sentBy': sentBy,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'isDeleted': false
    });
  }

  Future<List<Chat>> getChatList() async {
    final chatSnapshot = await _db.ref("/chats").get();

    Map<String, dynamic> chatsMap =
        Map<String, dynamic>.from(chatSnapshot.value as Map<dynamic, dynamic>);

    List<Chat> chatList = [];
    for (var key in chatsMap.keys) {
      Chat chat = Chat.fromRTDB(key,
          Map<String, dynamic>.from(chatsMap[key] as Map<dynamic, dynamic>));
      chatList.add(chat);
    }

    return chatList;
  }

  Future<List<ChatMessage>> getChatMessageList(String chatUid) async {
    final chatMessageSnapshot = await _db.ref("/chatMessages/$chatUid").get();

    Map<String, dynamic> chatMessagesMap = Map<String, dynamic>.from(
        chatMessageSnapshot.value as Map<dynamic, dynamic>);

    List<ChatMessage> chatMessageList = [];
    for (var key in chatMessagesMap.keys) {
      ChatMessage chatMessage =
          ChatMessage.fromRTDB(chatUid, chatMessagesMap[key]);
      chatMessageList.add(chatMessage);
    }

    return chatMessageList;
  }

  // storeChatMessagesToLocal() {
  //   final chatMessageStream = _db.ref("/chatMessages/$chatUid").onValue;
  //   final streamToPublish = chatMessageStream.map((event) {
  //     final chatMessageMap = Map<String, dynamic>.from(
  //         event.snapshot.value as Map<dynamic, dynamic>);
  //     final chatMessageList = chatMessageMap.entries.map((element) {
  //       return ChatMessage.fromRTDB(Map<String, dynamic>.from(element.value));
  //     }).toList();
  //     return chatMessageList;
  //   });

  //   print(streamToPublish.toString());
  // }

  createChat(List<String> members, int createdAt, int updatedAt) {
    DatabaseReference ref = _db.ref("/chats");

    ref.push().set({
      "members": members,
      "lastMessageSent": '',
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "isDeleted": false
    }).then((response) {});
  }

  void _updateChat(String uid, String lastMessageSent, int updatedAt) async {
    DatabaseReference ref = _db.ref("/chats/$uid");

    ref.update({
      "lastMessageSent": lastMessageSent,
      "updatedAt": updatedAt,
    });
  }

  getChatUIDByMembers(List<String> members) async {
    String chatUid = '';
    await _db.ref('/chats').get().then((snapshot) {
      final chats =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);

      List<Map<String, dynamic>> chatList = [];
      chats.forEach((key, value) {
        final chat = Map<String, dynamic>.from(value);
        chatList.add({'uid': key, 'members': chat['members']});
      });

      for (var chat in chatList) {
        if (chat['members'][0] == members[0] ||
            chat['members'][0] == members[1] &&
                chat['members'][1] == members[0] ||
            chat['members'][1] == members[1]) {
          chatUid = chat['uid'];
        }
      }
    }).catchError((error) {
      print(error);
    });

    return chatUid;
  }

  getChatMessages(String chatUid) {
    DatabaseReference ref = _db.ref("/chatMessages/$chatUid");

    ref.onValue.listen((event) {});
  }
}
